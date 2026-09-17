{{/*
Slug of the pinned guide ref, used in the Job/ConfigMap names so that bumping
guide.ref creates a new Job (Job specs are immutable) while an unchanged ref
keeps the completed Job in place and the Application in sync.
*/}}
{{- define "maasInstall.refSlug" -}}
{{- .Values.guide.ref | lower | replace "." "-" | replace "/" "-" | replace "_" "-" | trunc 30 | trimSuffix "-" -}}
{{- end -}}

{{/* Arguments passed to setup-maas.sh */}}
{{- define "maasInstall.args" -}}
{{- $args := list "--rhoai-version" .Values.guide.rhoaiVersion -}}
{{- if .Values.args.skipModels }}{{- $args = append $args "--skip-models" -}}{{- end -}}
{{- if .Values.args.skipVerify }}{{- $args = append $args "--skip-verify" -}}{{- end -}}
{{- if .Values.args.withObservability }}{{- $args = append $args "--with-observability" -}}{{- end -}}
{{- if .Values.args.maasHostname }}{{- $args = concat $args (list "--maas-hostname" .Values.args.maasHostname) -}}{{- end -}}
{{- $args = concat $args .Values.args.extraArgs -}}
{{- toYaml $args -}}
{{- end -}}
