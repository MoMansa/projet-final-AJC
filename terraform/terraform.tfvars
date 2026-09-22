project_id      = "poei-formation-gcp"
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