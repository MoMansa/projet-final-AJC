variable "project_id" {
  type = string
}

variable "equipe" {
  type = string
}

variable "alert_email" {
  type = string
}

variable "portail_public_ip" {
  description = "IP publique de l'Ingress portail-qualite (foodtrack-prod). Creee en Phase 2."
  type        = string
}
