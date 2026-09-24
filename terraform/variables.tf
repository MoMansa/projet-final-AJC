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

variable "backup_retention_days" {
  description = "Durée de conservation des sauvegardes"
  type        = number
  default     = 30
}

variable "logs_retention_days" {
  description = "Durée de conservation des journaux"
  type        = number
  default     = 30
}

variable "force_destroy_buckets" {
  description = "Autorise la suppression des buckets non vides"
  type        = bool
  default     = false
}

variable "master_authorized_cidr" {
  description = "Plage autorisée à joindre l'endpoint public GKE"
  type        = string
}

variable "node_machine_type" {
  description = "Type de machine du node pool"
  type        = string
}

variable "node_count" {
  description = "Nombre initial de nœuds"
  type        = number
}

variable "node_disk_type" {
  description = "Type de disque des nœuds"
  type        = string
}

variable "node_disk_size_gb" {
  description = "Taille du disque de démarrage des nœuds"
  type        = number
}

variable "bastion_machine_type" {
  description = "Type de machine du bastion"
  type        = string
}

variable "alert_email" {
  type = string
}

variable "portail_public_ip" {
  description = "IP de l'Ingress foodtrack-prod"
  type        = string
}