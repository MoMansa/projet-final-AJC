locals {
  network_name        = "${var.resource_prefix}-vpc"
  subnetwork_name     = "${var.resource_prefix}-subnet"
  pods_range_name     = "${var.resource_prefix}-pods"
  services_range_name = "${var.resource_prefix}-services"
  router_name         = "${var.resource_prefix}-router"
  nat_name            = "${var.resource_prefix}-nat"
  bastion_network_tag = "${var.resource_prefix}-bastion"
}

# CREATION DU RESEAU VPC

resource "google_compute_network" "foodtrack" {
  project = var.project_id
  name    = local.network_name

  auto_create_subnetworks         = false
  routing_mode                    = "REGIONAL"
  delete_default_routes_on_create = false
}

# CREATION DU SOUS-RESEAU

resource "google_compute_subnetwork" "foodtrack" {
  project = var.project_id
  name    = local.subnetwork_name
  region  = var.region
  network = google_compute_network.foodtrack.id

  ip_cidr_range            = var.subnet_cidr
  private_ip_google_access = true

  secondary_ip_range {
    range_name    = local.pods_range_name
    ip_cidr_range = var.pods_cidr
  }

  secondary_ip_range {
    range_name    = local.services_range_name
    ip_cidr_range = var.services_cidr
  }
}

# CREATION DU ROUTEUR

resource "google_compute_router" "foodtrack" {
  project = var.project_id
  name    = local.router_name
  region  = var.region
  network = google_compute_network.foodtrack.id
}

# CREATION DU NAT

resource "google_compute_router_nat" "foodtrack" {
  project = var.project_id
  name    = local.nat_name
  region  = var.region
  router  = google_compute_router.foodtrack.name

  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"

  subnetwork {
    name                    = google_compute_subnetwork.foodtrack.id
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}

# CREATION DU FIREWALL POUR AUTORISER LE BASTION A ETRE JOINT PAR IAP

resource "google_compute_firewall" "allow_iap_ssh" {
  project = var.project_id
  name    = "${var.resource_prefix}-allow-iap-ssh"
  network = google_compute_network.foodtrack.id

  description   = "Autorise SSH vers le bastion uniquement depuis Google Cloud IAP"
  direction     = "INGRESS"
  priority      = 1000
  source_ranges = var.iap_ssh_source_ranges
  target_tags   = [local.bastion_network_tag]

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }
}