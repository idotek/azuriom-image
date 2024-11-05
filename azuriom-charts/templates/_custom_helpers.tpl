{{- define "generatePvc" -}}
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: pvc-{{ .Release.Name }}-{{ .name }}
  labels:
    {{- include "azuriom-charts.labels" . | nindent 4 }}
spec:
  accessModes:
    - {{ .accessMode }}
  resources:
    requests:
      storage: {{ .size }}
  {{- if .storageClass }}
    storageClassName: {{.storageClass}}
  {{- end -}}
{{- end -}}