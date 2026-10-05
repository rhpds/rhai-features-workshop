{{- define "lmeval-patch-script" -}}
CUSTOM_IMAGE="{{ .Values.lmEvalImagePatcher.adapterImage }}"
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

for CM in evalhub-provider-lm-evaluation-harness trustyai-service-operator-evalhub-provider-lm-evaluation-harness; do
  if ! oc get configmap "$CM" -n {{ .Values.dashboardNamespace }} 2>/dev/null; then
    echo "Configmap $CM not found, skipping"
    continue
  fi

  CURRENT_IMAGE=$(oc get configmap "$CM" -n {{ .Values.dashboardNamespace }} \
    -o jsonpath='{.data.lm_evaluation_harness\.yaml}' | grep 'image:' | awk '{print $2}')

  if [ "$CURRENT_IMAGE" = "$CUSTOM_IMAGE" ]; then
    echo "Configmap $CM already has correct image, skipping"
    continue
  fi

  echo "Patching $CM: $CURRENT_IMAGE -> $CUSTOM_IMAGE"
  YAML=$(oc get configmap "$CM" -n {{ .Values.dashboardNamespace }} -o jsonpath='{.data.lm_evaluation_harness\.yaml}')
  PATCHED=$(echo "$YAML" | sed "s|image:.*|image: ${CUSTOM_IMAGE}|g")

  # Use oc patch to avoid ownerReference permission issues with oc replace
  ESCAPED=$(echo "$PATCHED" | python3 -c 'import sys,json; print(json.dumps(sys.stdin.read()))')
  oc patch configmap "$CM" -n {{ .Values.dashboardNamespace }} \
    --type=merge -p "{\"data\":{\"lm_evaluation_harness.yaml\":${ESCAPED}}}"

  oc annotate configmap "$CM" -n {{ .Values.dashboardNamespace }} \
    opendatahub.io/managed='false' --overwrite

  CHANGED=true
  echo "Configmap $CM patched"
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
