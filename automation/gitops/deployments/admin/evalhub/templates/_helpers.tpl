{{- define "lmeval-patch-script" -}}
LMEVAL_IMAGE="{{ .Values.lmEvalImagePatcher.adapterImage }}"
RAGAS_IMAGE="{{ .Values.lmEvalImagePatcher.ragasImage }}"
CHANGED=false

# Wait for EvalHub to be healthy
echo "Waiting for EvalHub to be ready..."
for i in $(seq 1 60); do
  READY=$(oc get deploy evalhub -n {{ .Values.dashboardNamespace }} -o jsonpath='{.status.readyReplicas}' 2>/dev/null)
  if [ "$READY" -ge 1 ] 2>/dev/null; then
    echo "EvalHub is ready"
    break
  fi
  echo "  attempt $i/60 - not ready yet, sleeping 10s..."
  sleep 10
done

READY=$(oc get deploy evalhub -n {{ .Values.dashboardNamespace }} -o jsonpath='{.status.readyReplicas}' 2>/dev/null)
if ! [ "$READY" -ge 1 ] 2>/dev/null; then
  echo "ERROR: EvalHub not ready after 10 minutes"
  exit 1
fi

patch_configmap() {
  local CM="$1" DATA_KEY="$2" DESIRED_IMAGE="$3"
  if ! oc get configmap "$CM" -n {{ .Values.dashboardNamespace }} 2>/dev/null; then
    echo "Configmap $CM not found, skipping"
    return
  fi

  CURRENT_IMAGE=$(oc get configmap "$CM" -n {{ .Values.dashboardNamespace }} -o json \
    | python3 -c "import sys,json; d=json.load(sys.stdin); print(d['data'].get('$DATA_KEY',''))" \
    | grep 'image:' | awk '{print $2}')

  if [ "$CURRENT_IMAGE" = "$DESIRED_IMAGE" ]; then
    echo "Configmap $CM already has correct image, skipping"
    return
  fi

  echo "Patching $CM: $CURRENT_IMAGE -> $DESIRED_IMAGE"

  # Use python3 to safely build the JSON patch and write to a temp file
  oc get configmap "$CM" -n {{ .Values.dashboardNamespace }} -o json \
    | python3 -c "
import sys, json
d = json.load(sys.stdin)
key = '$DATA_KEY'
yaml_str = d['data'][key]
yaml_str = yaml_str.split('\n')
yaml_str = [l.replace(l.split('image:')[1].strip(), '$DESIRED_IMAGE') if 'image:' in l else l for l in yaml_str]
patched = '\n'.join(yaml_str)
patch = {'data': {key: patched}}
with open('/tmp/cm-patch.json', 'w') as f:
    json.dump(patch, f)
"

  oc patch configmap "$CM" -n {{ .Values.dashboardNamespace }} \
    --type=merge --patch-file /tmp/cm-patch.json

  oc annotate configmap "$CM" -n {{ .Values.dashboardNamespace }} \
    opendatahub.io/managed='false' --overwrite

  CHANGED=true
  echo "Configmap $CM patched"
}

# Patch lm-evaluation-harness configmaps
for CM in evalhub-provider-lm-evaluation-harness trustyai-service-operator-evalhub-provider-lm-evaluation-harness; do
  patch_configmap "$CM" "lm_evaluation_harness.yaml" "$LMEVAL_IMAGE"
done

# Patch ragas configmaps
for CM in evalhub-provider-ragas trustyai-service-operator-evalhub-provider-ragas; do
  patch_configmap "$CM" "ragas.yaml" "$RAGAS_IMAGE"
done

if [ "$CHANGED" = "true" ]; then
  echo "Configmap changed — restarting EvalHub once to pick up new provider config..."
  oc rollout restart deploy/evalhub -n {{ .Values.dashboardNamespace }}
  oc rollout status deploy/evalhub -n {{ .Values.dashboardNamespace }} --timeout=120s
  echo "EvalHub restarted"
else
  echo "No changes needed"
fi

echo "Done"
{{- end }}
