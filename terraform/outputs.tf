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