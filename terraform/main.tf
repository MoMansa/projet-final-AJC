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

  network_id          = module.reseau.network_id
  subnetwork_id       = module.reseau.subnetwork_id
  pods_range_name     = module.reseau.pods_range_name
  services_range_name = module.reseau.services_range_name

  master_ipv4_cidr       = var.master_ipv4_cidr
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

module "wif_github" {
  source = "./modules/wif-github"

  project_id   = var.project_id
  github_owner = var.github_owner
  github_repo  = var.github_repo
}

resource "google_storage_bucket_iam_member" "ci_tfstate" {
  bucket = "foodtrack-b-tfstate-form-gke-eleve02-618b"
  role   = "roles/storage.objectAdmin"
  member = "serviceAccount:${module.wif_github.ci_service_account_email}"
}

resource "google_project_iam_member" "ci_lecture_plan" {
  for_each = toset([
    "roles/compute.viewer",
    "roles/storage.bucketViewer",
    "roles/iam.securityReviewer",
    "roles/iam.workloadIdentityPoolViewer"
  ])

  project = var.project_id
  role    = each.value
  member  = "serviceAccount:${module.wif_github.ci_service_account_email}"
}

resource "google_storage_bucket_iam_member" "ci_etat_terraform" {
  bucket = "foodtrack-b-tfstate-${var.project_id}"
  role   = "roles/storage.objectAdmin"
  member = "serviceAccount:${module.wif_github.ci_service_account_email}"
}

resource "google_artifact_registry_repository_iam_member" "noeuds_gke_images" {
  project    = var.project_id
  location   = var.region
  repository = "foodtrack-b-images"
  role       = "roles/artifactregistry.reader"
  member     = "serviceAccount:foodtrack-b-gke-nodes@${var.project_id}.iam.gserviceaccount.com"
}