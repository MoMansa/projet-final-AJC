module "reseau" {
  source = "./modules/reseau"

  project_id      = var.project_id
  region          = var.region
  resource_prefix = var.resource_prefix

  subnet_cidr   = var.subnet_cidr
  pods_cidr     = var.pods_cidr
  services_cidr = var.services_cidr
}

module "stockage" {
  source = "./modules/stockage"

  project_id      = var.project_id
  region          = var.region
  resource_prefix = var.resource_prefix

  backup_retention_days = var.backup_retention_days
  logs_retention_days   = var.logs_retention_days
  force_destroy_buckets = var.force_destroy_buckets
}

module "compute" {
  source = "./modules/compute"

  project_id      = var.project_id
  zone            = var.zone
  resource_prefix = var.resource_prefix

  network_id         = module.reseau.network_id
  subnetwork_id      = module.reseau.subnetwork_id
  pods_range_name    = module.reseau.pods_range_name
  services_range_name = module.reseau.services_range_name

  master_ipv4_cidr      = var.master_ipv4_cidr
  master_authorized_cidr = var.master_authorized_cidr

  node_machine_type = var.node_machine_type
  node_count        = var.node_count
  node_disk_type    = var.node_disk_type
  node_disk_size_gb = var.node_disk_size_gb

  bastion_machine_type = var.bastion_machine_type
  bastion_network_tag  = module.reseau.bastion_network_tag

  # Garantit que Cloud NAT et la règle IAP existent avant les VM.
  depends_on = [
    module.reseau,
  ]
}