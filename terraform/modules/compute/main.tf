locals {
  cluster_name              = "${var.resource_prefix}-cluster"
  node_pool_name            = "${var.resource_prefix}-pool"
  gke_service_account_id    = "${var.resource_prefix}-gke-nodes"
  bastion_name              = "${var.resource_prefix}-bastion"
  bastion_service_account_id = "${var.resource_prefix}-bastion"

  gke_node_roles = toset([
    "roles/logging.logWriter",
    "roles/monitoring.metricWriter",
    "roles/monitoring.viewer",
    "roles/stackdriver.resourceMetadata.writer"
  ])
}

# Compte de service des nœuds GKE

resource "google_service_account" "gke_nodes" {
  project = var.project_id

  account_id   = local.gke_service_account_id
  display_name = "Nœuds GKE FoodTrack équipe B"
  description  = "Compte de service dédié aux nœuds du cluster FoodTrack"
}

resource "google_project_iam_member" "gke_node_roles" {
  for_each = local.gke_node_roles

  project = var.project_id
  role    = each.value
  member  = "serviceAccount:${google_service_account.gke_nodes.email}"
}



# Cluster GKE

resource "google_container_cluster" "foodtrack" {
  project  = var.project_id
  name     = local.cluster_name
  location = var.zone

  network    = var.network_id
  subnetwork = var.subnetwork_id

  networking_mode = "VPC_NATIVE"

  # Le node pool par défaut est créé temporairement puis supprimé.
  # Le node pool réellement utilisé est géré séparément plus bas.
  remove_default_node_pool = true
  initial_node_count       = 1

  deletion_protection = false

  ip_allocation_policy {
    cluster_secondary_range_name  = var.pods_range_name
    services_secondary_range_name = var.services_range_name
  }

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false
    master_ipv4_cidr_block  = var.master_ipv4_cidr
  }

  # Les runners GitHub hébergés ont des adresses publiques variables.
  # Le compromis 0.0.0.0/0 doit être documenté dans le README.
  master_authorized_networks_config {
    cidr_blocks {
      cidr_block   = var.master_authorized_cidr
      display_name = "github-hosted-runners"
    }
  }

  master_auth {
    client_certificate_config {
      issue_client_certificate = false
    }
  }

  release_channel {
    channel = "REGULAR"
  }

  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }

  logging_service    = "logging.googleapis.com/kubernetes"
  monitoring_service = "monitoring.googleapis.com/kubernetes"

  addons_config {
    http_load_balancing {
      disabled = false
    }

    horizontal_pod_autoscaling {
      disabled = false
    }

    gce_persistent_disk_csi_driver_config {
      enabled = true
    }
  }

  enable_shielded_nodes = true

}

# Node pool GKE

resource "google_container_node_pool" "foodtrack" {
  project  = var.project_id
  name     = local.node_pool_name
  location = var.zone
  cluster  = google_container_cluster.foodtrack.id

  node_count = var.node_count

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  upgrade_settings {
    max_surge       = 1
    max_unavailable = 0
  }

  node_config {
    machine_type = var.node_machine_type
    image_type   = "COS_CONTAINERD"

    disk_type    = var.node_disk_type
    disk_size_gb = var.node_disk_size_gb

    service_account = google_service_account.gke_nodes.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]

    metadata = {
      disable-legacy-endpoints = "true"
    }

    workload_metadata_config {
      mode = "GKE_METADATA"
    }

    shielded_instance_config {
      enable_secure_boot          = true
      enable_integrity_monitoring = true
    }

    tags = [
      "${var.resource_prefix}-gke-node",
    ]
  }

  depends_on = [
    google_project_iam_member.gke_node_roles,
  ]
}



# Compte de service du bastion

resource "google_service_account" "bastion" {
  project = var.project_id

  account_id   = local.bastion_service_account_id
  display_name = "Bastion FoodTrack équipe B"
  description  = "Compte de service dédié à la VM bastion"
}

# VM bastion

resource "google_compute_instance" "bastion" {
  project = var.project_id

  name         = local.bastion_name
  zone         = var.zone
  machine_type = var.bastion_machine_type

  allow_stopping_for_update = true
  can_ip_forward            = false

  tags = [
    var.bastion_network_tag,
  ]

  boot_disk {
    auto_delete = true

    initialize_params {
      image = "debian-cloud/debian-12"
      type  = "pd-standard"
      size  = 10
    }
  }

  network_interface {
    network    = var.network_id
    subnetwork = var.subnetwork_id

    # Aucun bloc access_config : le bastion ne reçoit aucune IP publique.
  }

  metadata = {
    enable-oslogin         = "TRUE"
    block-project-ssh-keys = "TRUE"
  }

  service_account {
    email = google_service_account.bastion.email
    scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }

  shielded_instance_config {
    enable_secure_boot          = true
    enable_vtpm                 = true
    enable_integrity_monitoring = true
  }
}

