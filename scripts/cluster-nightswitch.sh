#!/usr/bin/env bash
# Eteint (off) ou rallume (on) le node pool GKE.
# Usage : ./cluster-nightswitch.sh off|on
set -euo pipefail

EQUIPE="${EQUIPE:-b}"
ZONE="${ZONE:-$(gcloud config get-value compute/zone 2>/dev/null)}"
CLUSTER="foodtrack-${EQUIPE}-cluster"
POOL="foodtrack-${EQUIPE}-pool"
NODE_COUNT_ON="${NODE_COUNT_ON:-2}"

[ $# -eq 1 ] && { [ "$1" = "off" ] || [ "$1" = "on" ]; } || { echo "Usage: $0 off|on"; exit 1; }
[ -n "$ZONE" ] || { echo "Variable ZONE requise"; exit 1; }

if [ "$1" = "off" ]; then
  NUM_NODES=0
  echo "[$(date '+%H:%M:%S')] Extinction du cluster ${CLUSTER} (zone ${ZONE})"
else
  NUM_NODES="$NODE_COUNT_ON"
  echo "[$(date '+%H:%M:%S')] Rallumage du cluster ${CLUSTER} (zone ${ZONE})"
fi

AVANT="$(gcloud container clusters describe "$CLUSTER" --zone "$ZONE" --format='value(currentNodeCount)')"
echo "[$(date '+%H:%M:%S')] Noeuds actuels : ${AVANT:-0} -> cible : ${NUM_NODES}"

gcloud container clusters resize "$CLUSTER" \
  --node-pool "$POOL" \
  --num-nodes "$NUM_NODES" \
  --zone "$ZONE" \
  --quiet

APRES="$(gcloud container clusters describe "$CLUSTER" --zone "$ZONE" --format='value(currentNodeCount)')"
echo "[$(date '+%H:%M:%S')] Termine. Noeuds actuels : ${APRES:-0}"