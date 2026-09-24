#!/usr/bin/env bash
# Sauvegarde la config Kubernetes (ConfigMaps, Deployments, etc.) vers le bucket de sauvegarde.
# Usage : ./backup-config.sh
set -euo pipefail

EQUIPE="${EQUIPE:-b}"
PROJECT="${PROJECT:-$(gcloud config get-value project 2>/dev/null)}"
BUCKET="${BACKUP_BUCKET:-foodtrack-${EQUIPE}-backups-${PROJECT}}"
DATE="$(date -u +%Y%m%dT%H%M%SZ)"
DOSSIER="$(mktemp -d)"

for ns in foodtrack-dev foodtrack-test foodtrack-prod; do
  mkdir -p "$DOSSIER/$ns"
  kubectl get configmap,deployment,statefulset,service,ingress,hpa,pvc -n "$ns" -o yaml \
    > "$DOSSIER/$ns/config.yaml"
done

ARCHIVE="/tmp/foodtrack-${EQUIPE}-config-${DATE}.tar.gz"
tar -czf "$ARCHIVE" -C "$DOSSIER" .
gcloud storage cp "$ARCHIVE" "gs://${BUCKET}/$(basename "$ARCHIVE")"

rm -rf "$DOSSIER" "$ARCHIVE"
echo "Sauvegarde envoyee : gs://${BUCKET}/$(basename "$ARCHIVE")"