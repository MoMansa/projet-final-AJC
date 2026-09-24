output "backup_bucket_name" {
  description = "Nom du bucket de sauvegardes"
  value       = google_storage_bucket.backups.name
}

output "backup_bucket_url" {
  description = "URL GCS du bucket de sauvegardes"
  value       = google_storage_bucket.backups.url
}

output "logs_bucket_name" {
  description = "Nom du bucket d'exports de journaux"
  value       = google_storage_bucket.logs.name
}

output "logs_bucket_url" {
  description = "URL GCS du bucket d'exports de journaux"
  value       = google_storage_bucket.logs.url
}

output "artifact_repository_name" {
  description = "Nom du dépôt Docker Artifact Registry"
  value       = google_artifact_registry_repository.images.repository_id
}

output "artifact_repository_url" {
  description = "Adresse du dépôt Docker Artifact Registry"
  value       = "${var.region}-docker.pkg.dev/${var.project_id}/${google_artifact_registry_repository.images.repository_id}"
}