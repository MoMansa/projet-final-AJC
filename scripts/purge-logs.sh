#!/usr/bin/env bash
# Supprime les exports de journaux vieux de plus de 30 jours.
# Usage : ./purge-logs.sh
set -euo pipefail

EQUIPE="${EQUIPE:-b}"
BUCKET="${LOGS_BUCKET:-foodtrack-${EQUIPE}-logs}"
RETENTION_JOURS="${RETENTION_DAYS:-30}"
CUTOFF="$(date -u -d "-${RETENTION_JOURS} days" +%s)"

gsutil ls -l "gs://${BUCKET}/**" 2>/dev/null | grep 'gs://' | while read -r _taille date chemin; do
  epoch="$(date -u -d "$date" +%s)"
  if [ "$epoch" -lt "$CUTOFF" ]; then
    gsutil rm "$chemin"
    echo "supprime : $chemin"
  fi
done
