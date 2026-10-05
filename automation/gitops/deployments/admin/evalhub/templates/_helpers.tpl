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

  CURRENT_IMAGE=$(oc get configmap "$CM" -n {{ .Values.dashboardNamespace }} \
    -o jsonpath="{.data.${DATA_KEY}}" | grep 'image:' | awk '{print $2}')

  if [ "$CURRENT_IMAGE" = "$DESIRED_IMAGE" ]; then
    echo "Configmap $CM already has correct image, skipping"
    return
  fi

  echo "Patching $CM: $CURRENT_IMAGE -> $DESIRED_IMAGE"
  YAML=$(oc get configmap "$CM" -n {{ .Values.dashboardNamespace }} -o jsonpath="{.data.${DATA_KEY}}")
  PATCHED=$(echo "$YAML" | sed "s|image:.*|image: ${DESIRED_IMAGE}|g")

  ESCAPED=$(echo "$PATCHED" | python3 -c 'import sys,json; print(json.dumps(sys.stdin.read()))')
  oc patch configmap "$CM" -n {{ .Values.dashboardNamespace }} \
    --type=merge -p "{\"data\":{\"${DATA_KEY}\":${ESCAPED}}}"

  oc annotate configmap "$CM" -n {{ .Values.dashboardNamespace }} \
    opendatahub.io/managed='false' --overwrite

  CHANGED=true
  echo "Configmap $CM patched"
}

# Patch lm-evaluation-harness configmaps
for CM in evalhub-provider-lm-evaluation-harness trustyai-service-operator-evalhub-provider-lm-evaluation-harness; do
  patch_configmap "$CM" "lm_evaluation_harness\.yaml" "$LMEVAL_IMAGE"
done

# Patch ragas configmaps
for CM in evalhub-provider-ragas trustyai-service-operator-evalhub-provider-ragas; do
  patch_configmap "$CM" "ragas\.yaml" "$RAGAS_IMAGE"
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
