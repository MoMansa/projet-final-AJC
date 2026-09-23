output "uptime_check_id" {
  value = google_monitoring_uptime_check_config.portail_prod.uptime_check_id
}

output "alert_policy_name" {
  value = google_monitoring_alert_policy.portail_indisponible.name
}

output "log_based_metric_name" {
  value = google_logging_metric.erreurs_prod.name
}

output "dashboard_id" {
  value = google_monitoring_dashboard.foodtrack_prod.id
}
