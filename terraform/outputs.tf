output "network_name" {
  description = "Nom du VPC de l'équipe B"
  value       = module.reseau.network_name
}

output "subnetwork_name" {
  description = "Nom du sous-réseau de l'équipe B"
  value       = module.reseau.subnetwork_name
}

output "pods_range_name" {
  description = "Nom de la plage secondaire des pods"
  value       = module.reseau.pods_range_name
}

output "services_range_name" {
  description = "Nom de la plage secondaire des services"
  value       = module.reseau.services_range_name
}

output "router_name" {
  description = "Nom du Cloud Router"
  value       = module.reseau.router_name
}

output "nat_name" {
  description = "Nom du Cloud NAT"
  value       = module.reseau.nat_name
}

output "backup_bucket_name" {
  description = "Nom du bucket de sauvegardes"
  value       = module.stockage.backup_bucket_name
}

output "logs_bucket_name" {
  description = "Nom du bucket d'exports de journaux"
  value       = module.stockage.logs_bucket_name
}

output "cluster_name" {
  description = "Nom du cluster GKE"
  value       = module.compute.cluster_name
}

output "cluster_location" {
  description = "Zone du cluster GKE"
  value       = module.compute.cluster_location
}

output "node_pool_name" {
  description = "Nom du node pool"
  value       = module.compute.node_pool_name
}

output "gke_service_account_email" {
  description = "Compte de service des nœuds GKE"
  value       = module.compute.gke_service_account_email
}

output "bastion_name" {
  description = "Nom de la VM bastion"
  value       = module.compute.bastion_name
}

output "bastion_internal_ip" {
  description = "Adresse privée du bastion"
  value       = module.compute.bastion_internal_ip
}