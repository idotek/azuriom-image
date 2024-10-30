{{- define "generatePvc" -}}
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: pvc-{{ .Release.Name }}-{{ .name }}
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