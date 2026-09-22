module "reseau" {
  source = "./modules/reseau"

  project_id      = var.project_id
  region          = var.region
  resource_prefix = var.resource_prefix

  subnet_cidr   = var.subnet_cidr
  pods_cidr     = var.pods_cidr
  services_cidr = var.services_cidr
}