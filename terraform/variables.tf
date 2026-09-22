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