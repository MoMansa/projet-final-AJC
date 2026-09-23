#!/usr/bin/env bash
# Regroupe les commandes d'audit securite. A rediriger vers un fichier :
#   ZONE=europe-west3-b ./audit_iam.sh > audit.txt
set -uo pipefail

EQUIPE="${EQUIPE:-b}"
PROJECT="${PROJECT:-foodtrack-equipe-${EQUIPE}}"
CLUSTER="foodtrack-${EQUIPE}-cluster"
BASTION="foodtrack-${EQUIPE}-bastion"

echo "== Roles sur le projet =="
gcloud projects get-iam-policy "$PROJECT" \
  --flatten="bindings[].members" \
  --format="table(bindings.role,bindings.members)"

echo; echo "== Comptes de service =="
gcloud iam service-accounts list --project "$PROJECT"

echo; echo "== Pare-feu =="
gcloud compute firewall-rules list --project "$PROJECT" \
  --format="table(name,sourceRanges.list(),targetTags.list(),allowed[].map().firewall_rule().list())"

if [ -n "${ZONE:-}" ]; then
  echo; echo "== Bastion =="
  gcloud compute instances describe "$BASTION" --zone "$ZONE" --format="yaml(metadata.items)"

  echo; echo "== Exposition du plan de controle =="
  gcloud container clusters describe "$CLUSTER" --zone "$ZONE" \
    --format="yaml(privateClusterConfig,masterAuthorizedNetworksConfig)"
fi

echo; echo "== Secrets dans l'historique Git (lancer depuis le depot) =="
git log --all --full-history --name-only --pretty=format:%h -- "*.json" "*.tfvars" ".env"
