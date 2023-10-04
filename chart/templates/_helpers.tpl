{{/*
Expand the name of the chart.
*/}}
{{- define "helmArgie.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Check if a list contains a value
*/}}
{{- define "listContains" -}}
  {{- $value := .value -}}
  {{- $list := .list -}}
  {{- $found := false -}}
  {{- range $list -}}
    {{- if eq . $value -}}
      {{- $found = true -}}
    {{- end -}}
  {{- end -}}
  {{- $found -}}
{{- end -}}

{{- define "quoteStrings" -}}
{{- if kindIs "string" . -}}
{{ printf "%q" . }}
{{- else if kindIs "map" . -}}
{{- range $key, $value := . -}}
{{ $key | quote }}: {{ include "quoteStrings" $value }}
{{- end -}}
{{- else if kindIs "slice" . -}}
{{- range $value := . -}}
- {{ include "quoteStrings" $value }}
{{- end -}}
{{- else -}}
{{ . | quote }}
{{- end -}}
{{- end -}}
