output "cluster_id" {
  description = "Identifiant du cluster GKE"
  value       = google_container_cluster.foodtrack.id
}

output "cluster_name" {
  description = "Nom du cluster GKE"
  value       = google_container_cluster.foodtrack.name
}

output "cluster_location" {
  description = "Zone du cluster GKE"
  value       = google_container_cluster.foodtrack.location
}

output "cluster_endpoint" {
  description = "Endpoint du plan de contrôle GKE"
  value       = google_container_cluster.foodtrack.endpoint
}

output "node_pool_name" {
  description = "Nom du node pool"
  value       = google_container_node_pool.foodtrack.name
}

output "gke_service_account_email" {
  description = "Adresse du compte de service des nœuds GKE"
  value       = google_service_account.gke_nodes.email
}

output "bastion_name" {
  description = "Nom de la VM bastion"
  value       = google_compute_instance.bastion.name
}

output "bastion_internal_ip" {
  description = "Adresse IP privée du bastion"
  value       = google_compute_instance.bastion.network_interface[0].network_ip
}

output "bastion_service_account_email" {
  description = "Adresse du compte de service du bastion"
  value       = google_service_account.bastion.email
}