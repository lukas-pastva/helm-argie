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

{{- define "quoteValues" -}}
{{- if kindIs "string" . -}}
{{ printf "%q" . }}
{{- else if kindIs "map" . -}}
{{- $first := true -}}
{{- range $key, $value := . -}}
{{- if not $first }}{{ printf "\n" }}{{- end -}}
{{ $key }}:
{{- if kindIs "map" $value -}}
{{ include "quoteValues" $value | nindent 2 }}
{{- else -}}
{{ include "quoteValues" $value }}
{{- end -}}
{{- $first = false -}}
{{- end -}}
{{- else if kindIs "slice" . -}}
{{- range $value := . -}}
-
{{- if kindIs "map" $value -}}
{{ include "quoteValues" $value | nindent 2 }}
{{- else -}}
{{ include "quoteValues" $value }}
{{- end -}}
{{- end -}}
{{- else -}}
{{ . | quote }}
{{- end -}}
{{- end -}}
