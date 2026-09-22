output "network_id" {
  description = "Identifiant du VPC FoodTrack"
  value       = google_compute_network.foodtrack.id
}

output "network_name" {
  description = "Nom du VPC FoodTrack"
  value       = google_compute_network.foodtrack.name
}

output "network_self_link" {
  description = "URL complète du VPC FoodTrack"
  value       = google_compute_network.foodtrack.self_link
}

output "subnetwork_id" {
  description = "Identifiant du sous-réseau FoodTrack"
  value       = google_compute_subnetwork.foodtrack.id
}

output "subnetwork_name" {
  description = "Nom du sous-réseau FoodTrack"
  value       = google_compute_subnetwork.foodtrack.name
}

output "subnetwork_self_link" {
  description = "URL complète du sous-réseau FoodTrack"
  value       = google_compute_subnetwork.foodtrack.self_link
}

output "pods_range_name" {
  description = "Nom de la plage secondaire des pods"
  value       = local.pods_range_name
}

output "services_range_name" {
  description = "Nom de la plage secondaire des services"
  value       = local.services_range_name
}

output "router_name" {
  description = "Nom du Cloud Router"
  value       = google_compute_router.foodtrack.name
}

output "nat_name" {
  description = "Nom du Cloud NAT"
  value       = google_compute_router_nat.foodtrack.name
}

output "bastion_network_tag" {
  description = "Tag réseau que devra porter le bastion"
  value       = local.bastion_network_tag
}