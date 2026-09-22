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