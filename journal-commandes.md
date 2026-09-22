# Ensemble des commandes utilisé dans le projet (tmp)


## Création de l'arborescence

```bash
mkdir -p \
  terraform/modules/reseau \
  terraform/modules/compute \
  terraform/modules/stockage
```

```bash
touch \
  terraform/versions.tf \
  terraform/backend.tf \
  terraform/providers.tf \
  terraform/main.tf \
  terraform/variables.tf \
  terraform/outputs.tf \
  terraform/team-b.tfvars.example \
  terraform/modules/reseau/main.tf \
  terraform/modules/reseau/variables.tf \
  terraform/modules/reseau/outputs.tf \
  terraform/modules/compute/main.tf \
  terraform/modules/compute/variables.tf \
  terraform/modules/compute/outputs.tf \
  terraform/modules/stockage/main.tf \
  terraform/modules/stockage/variables.tf \
  terraform/modules/stockage/outputs.tf
```