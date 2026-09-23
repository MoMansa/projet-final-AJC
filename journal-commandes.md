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

### Export des variables d'environnement associées au projet

```bash
export EQUIPE="b"
export PROJECT="poei-formation-gcp"
export REGION="europe-west3"
export ZONE="europe-west3-b"

export RESOURCE_PREFIX="foodtrack-b"

export VPC_NAME="foodtrack-b-vpc"
export SUBNET_NAME="foodtrack-b-subnet"
export ROUTER_NAME="foodtrack-b-router"
export NAT_NAME="foodtrack-b-nat"
export CLUSTER_NAME="foodtrack-b-cluster"
export NODE_POOL_NAME="foodtrack-b-pool"
export BASTION_NAME="foodtrack-b-bastion"
export AR_REPOSITORY="foodtrack-b-images"

export TFSTATE_BUCKET="foodtrack-b-tfstate-poei-formation-gcp"
```

### Creation du bucket initial de backend pour terraform

```bash
(base) allan@allan-fedora:~/Documents/Formation/AJC/Projet_final_multicloud/projet-final-AJC/terraform$ gcloud storage buckets create "gs://foodtrack-${EQUIPE}-tfstate-${PROJECT}" --location="$REGION" --uniform-bucket-level-access
Creating gs://foodtrack-b-tfstate-poei-formation-gcp/...
(base) allan@allan-fedora:~/Documents/Formation/AJC/Projet_final_multicloud/projet-final-AJC/terraform$ gcloud storage buckets update "gs://foodtrack-${EQUIPE}-tfstate-${PROJECT}" --versioning
Updating gs://foodtrack-b-tfstate-poei-formation-gcp/...                                                                                                                  
  Completed 1                                                                                                                                                             
(base) allan@allan-fedora:~/Documents/Formation/AJC/Projet_final_multicloud/projet-final-AJC/terraform$ 
```