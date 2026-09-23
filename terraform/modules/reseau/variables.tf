variable "project_id" {
  description = "Identifiant du projet Google Cloud"
  type        = string
  default     = "poei-formation-gcp"
}

variable "region" {
  description = "Région du sous-réseau, du routeur et du NAT"
  type        = string
  default     = "europe-west3"
}

variable "resource_prefix" {
  description = "Préfixe commun des ressources de l'équipe"
  type        = string
  default     = "foodtrack-b"
}

variable "subnet_cidr" {
  description = "Plage principale du sous-réseau"
  type        = string
  default     = "10.20.0.0/20"
}

variable "pods_cidr" {
  description = "Plage secondaire utilisée par les pods GKE"
  type        = string
  default     = "10.21.0.0/16"
}

variable "services_cidr" {
  description = "Plage secondaire utilisée par les services GKE"
  type        = string
  default     = "10.22.0.0/20"
}

variable "iap_ssh_source_ranges" {
  description = "Plages Google IAP autorisées à joindre le bastion en SSH"
  type        = list(string)
  default     = ["35.235.240.0/20"]
}