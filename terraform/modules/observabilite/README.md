# Module `observabilite`

Supervision de `foodtrack-prod` : canal d'alerte, uptime check, alerte, log-based metric, dashboard.

## Usage

```hcl
module "observabilite" {
  source            = "./modules/observabilite"
  project_id        = var.project_id
  equipe            = "b"
  alert_email       = "equipe-b@example.com"
  portail_public_ip = "34.12.xx.xx"  # adresse de l'Ingress, connue apres la Phase 2
}
```

## A vérifier une fois le cluster créé

- Le widget "latence du portail" dépend de `portail_public_ip` : sans lui, `terraform apply` échoue. Attendez que le Lead Kubernetes ait l'adresse de l'Ingress.
- Testez l'alerte pour de vrai (`kubectl scale deployment/portail-qualite -n foodtrack-prod --replicas=0` quelques minutes, puis remettez les replicas) — la grille de soutenance demande qu'elle se soit déclenchée au moins une fois, volontairement.
