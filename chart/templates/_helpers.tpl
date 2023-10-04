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
{{- $first := true -}}
{{- range $key, $value := . -}}
{{- if not $first }}{{ printf "\n" }}{{- end -}}
{{ $key | quote }}:
{{- if kindIs "map" $value -}}
{{ include "quoteStrings" $value | nindent 2 }}
{{- else -}}
{{ include "quoteStrings" $value }}
{{- end -}}
{{- $first = false -}}
{{- end -}}
{{- else if kindIs "slice" . -}}
{{- range $value := . -}}
-
{{- if kindIs "map" $value -}}
{{ include "quoteStrings" $value | nindent 2 }}
{{- else -}}
{{ include "quoteStrings" $value }}
{{- end -}}
{{- end -}}
{{- else -}}
{{ . | quote }}
{{- end -}}
{{- end -}}
