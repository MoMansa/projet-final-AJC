# Infrastructure GCP partagee par les namespaces dev, test et prod.
# Les differences applicatives sont gerees dans les manifestes Kubernetes.
project_id      = "form-gke-eleve02-618b"
region          = "europe-west3"
zone            = "europe-west3-b"
resource_prefix = "foodtrack-b"

subnet_cidr      = "10.20.0.0/20"
pods_cidr        = "10.21.0.0/16"
services_cidr    = "10.22.0.0/20"
master_ipv4_cidr = "172.16.2.0/28"

github_owner = "MoMansa"
github_repo  = "projet-final-AJC"

backup_retention_days = 30
logs_retention_days   = 30
force_destroy_buckets = false

# Endpoint public GKE accessible aux runners GitHub Actions : compromis documente.
master_authorized_cidr = "0.0.0.0/0"

node_machine_type    = "e2-standard-2"
node_count           = 2
node_disk_type       = "pd-standard"
node_disk_size_gb    = 50
bastion_machine_type = "e2-micro"

alert_email       = "21diouf.pape@gmail.com"
portail_public_ip = "136.81.158.21"