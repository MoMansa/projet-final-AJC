variable "project_id" {
  description = "Identifiant du projet Google Cloud partagé"
  type        = string
}

variable "region" {
  description = "Région attribuée à l'équipe B"
  type        = string
}

variable "zone" {
  description = "Zone du cluster GKE et du bastion"
  type        = string
}

variable "resource_prefix" {
  description = "Prefix utilisé par le projet pour nommer les ressources"
  type        = string
}

variable "github_owner" {
  description = "Propriétaire du dépôt GitHub"
  type        = string
}

variable "github_repo" {
  description = "Nom du dépôt GitHub"
  type        = string
}

/***
variable "subnet_cidr" {
  description = "Plage principale du sous-réseau de l'équipe B"
  type        = string
}

variable "pods_cidr" {
  description = "Plage secondaire des pods GKE"
  type        = string
}

variable "services_cidr" {
  description = "Plage secondaire des services GKE"
  type        = string
}

variable "master_ipv4_cidr" {
  description = "Plage privée du plan de contrôle GKE"
  type        = string
}
*/