{{- define "devops-demo.name" -}}
{{- .Chart.Name -}}
{{- end -}}
{{- define "devops-demo.fullname" -}}
{{- printf "%s-%s" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
