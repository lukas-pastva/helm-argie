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
