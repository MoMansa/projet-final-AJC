variable "project_id" {
  description = "Identifiant du projet Google Cloud"
  type        = string
}

variable "zone" {
  description = "Zone du cluster GKE et du bastion"
  type        = string
}

variable "resource_prefix" {
  description = "Préfixe commun des ressources de l'équipe"
  type        = string
}

variable "network_id" {
  description = "Identifiant du VPC"
  type        = string
}

variable "subnetwork_id" {
  description = "Identifiant du sous-réseau"
  type        = string
}

variable "pods_range_name" {
  description = "Nom de la plage secondaire des pods"
  type        = string
}

variable "services_range_name" {
  description = "Nom de la plage secondaire des services"
  type        = string
}

variable "master_ipv4_cidr" {
  description = "Plage privée du plan de contrôle GKE"
  type        = string
}

variable "master_authorized_cidr" {
  description = "Plage autorisée à joindre l'endpoint public de GKE"
  type        = string
}

variable "node_machine_type" {
  description = "Type de machine du node pool"
  type        = string

  validation {
    condition     = can(regex("^(e2|n2)-", var.node_machine_type))
    error_message = "Le type de machine doit appartenir à la famille E2 ou N2."
  }
}

variable "node_count" {
  description = "Nombre initial de nœuds"
  type        = number

  validation {
    condition     = var.node_count >= 1
    error_message = "Le node pool doit contenir au moins un nœud lors de sa création."
  }
}

variable "node_disk_type" {
  description = "Type de disque de démarrage des nœuds"
  type        = string

  validation {
    condition     = var.node_disk_type == "pd-standard"
    error_message = "Le cahier des charges impose le type pd-standard."
  }
}

variable "node_disk_size_gb" {
  description = "Taille du disque de démarrage des nœuds"
  type        = number

  validation {
    condition     = var.node_disk_size_gb >= 10 && var.node_disk_size_gb <= 50
    error_message = "La taille du disque doit être comprise entre 10 et 50 Go."
  }
}

variable "bastion_machine_type" {
  description = "Type de machine du bastion"
  type        = string
}

variable "bastion_network_tag" {
  description = "Tag réseau permettant l'accès SSH par IAP"
  type        = string
}