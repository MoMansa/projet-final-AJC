#!/usr/bin/env bash
# Supprime les exports de journaux vieux de plus de 30 jours.
# Usage : ./purge-logs.sh
set -euo pipefail

EQUIPE="${EQUIPE:-b}"
PROJECT="${PROJECT:-$(gcloud config get-value project 2>/dev/null)}"
BUCKET="${LOGS_BUCKET:-foodtrack-${EQUIPE}-logs-${PROJECT}}"
RETENTION_JOURS="${RETENTION_DAYS:-30}"
CUTOFF="$(date -u -d "-${RETENTION_JOURS} days" +%s)"

echo "Purge de gs://${BUCKET}/ (objets de plus de ${RETENTION_JOURS} jours)"

OBJETS="$(gcloud storage ls -l "gs://${BUCKET}/**" | grep 'gs://' || true)"

if [ -z "$OBJETS" ]; then
  echo "Bucket vide, rien a purger."
  exit 0
fi

echo "$OBJETS" | while read -r _taille date chemin; do
  epoch="$(date -u -d "$date" +%s)"
  if [ "$epoch" -lt "$CUTOFF" ]; then
    gcloud storage rm "$chemin"
    echo "supprime : $chemin"
  fi
done

echo "Termine."
