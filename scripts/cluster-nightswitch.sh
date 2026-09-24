#!/usr/bin/env bash
# Eteint (off) ou rallume (on) le node pool GKE.
# Usage : ZONE=europe-west3-b ./cluster-nightswitch.sh off|on
set -euo pipefail

EQUIPE="${EQUIPE:-b}"
CLUSTER="foodtrack-${EQUIPE}-cluster"
POOL="foodtrack-${EQUIPE}-pool"
NODE_COUNT_ON="${NODE_COUNT_ON:-2}"

[ $# -eq 1 ] && { [ "$1" = "off" ] || [ "$1" = "on" ]; } || { echo "Usage: $0 off|on"; exit 1; }
[ -n "${ZONE:-}" ] || { echo "Variable ZONE requise"; exit 1; }

NUM_NODES=0
[ "$1" = "on" ] && NUM_NODES="$NODE_COUNT_ON"

gcloud container clusters resize "$CLUSTER" \
  --node-pool "$POOL" \
  --num-nodes "$NUM_NODES" \
  --zone "$ZONE" \
  --quiet
