locals {
  artifact_repository_name = "${var.resource_prefix}-images"
  backup_bucket_name       = "${var.resource_prefix}-backups-${var.project_id}"
  logs_bucket_name         = "${var.resource_prefix}-logs-${var.project_id}"
}

# Creation d'un bucket pour la sauvegarde des données

resource "google_storage_bucket" "backups" {
  project = var.project_id

  name          = local.backup_bucket_name
  location      = var.region
  storage_class = "STANDARD"

  force_destroy               = var.force_destroy_buckets
  uniform_bucket_level_access = true
  public_access_prevention    = "enforced"

  versioning {
    enabled = true
  }

  lifecycle_rule {
    action {
      type = "Delete"
    }

    condition {
      age = var.backup_retention_days
    }
  }
}

# Création d'un bucket pour la sauvegarde des journaux d'audit

resource "google_storage_bucket" "logs" {
  project = var.project_id

  name          = local.logs_bucket_name
  location      = var.region
  storage_class = "STANDARD"

  force_destroy               = var.force_destroy_buckets
  uniform_bucket_level_access = true
  public_access_prevention    = "enforced"

  lifecycle_rule {
    action {
      type = "Delete"
    }

    condition {
      age = var.logs_retention_days
    }
  }
}