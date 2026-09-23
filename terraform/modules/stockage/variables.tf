variable "project_id" {
  description = "Identifiant du projet Google Cloud"
  type        = string
}

variable "region" {
  description = "Région des ressources de stockage"
  type        = string
}

variable "resource_prefix" {
  description = "Préfixe commun des ressources de l'équipe"
  type        = string
}

variable "backup_retention_days" {
  description = "Durée de conservation des sauvegardes en jours"
  type        = number
  default     = 30

  validation {
    condition     = var.backup_retention_days >= 1
    error_message = "La durée de conservation des sauvegardes doit être positive."
  }
}

variable "logs_retention_days" {
  description = "Durée de conservation des exports de journaux en jours"
  type        = number
  default     = 30

  validation {
    condition     = var.logs_retention_days >= 1
    error_message = "La durée de conservation des journaux doit être positive."
  }
}

variable "force_destroy_buckets" {
  description = "Autorise Terraform à supprimer les buckets non vides"
  type        = bool
  default     = false
}