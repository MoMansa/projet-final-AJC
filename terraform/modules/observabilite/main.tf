# Supervision de foodtrack-prod : alerte, uptime check, log-based metric, dashboard.

resource "google_monitoring_notification_channel" "email" {
  display_name = "foodtrack-${var.equipe}-email"
  type         = "email"
  labels = {
    email_address = var.alert_email
  }
}

resource "google_monitoring_uptime_check_config" "portail_prod" {
  display_name = "foodtrack-${var.equipe}-uptime-portail-prod"
  timeout      = "10s"
  period       = "60s"

  http_check {
    path = "/healthz"
    port = 80
  }

  monitored_resource {
    type = "uptime_url"
    labels = {
      project_id = var.project_id
      host       = var.portail_public_ip
    }
  }
}

resource "google_monitoring_alert_policy" "portail_indisponible" {
  display_name = "foodtrack-${var.equipe}-alerte-portail-prod"
  combiner     = "OR"

  conditions {
    display_name = "Uptime check en echec"
    condition_threshold {
      filter          = "resource.type=\"uptime_url\" AND metric.type=\"monitoring.googleapis.com/uptime_check/check_passed\" AND metric.label.\"check_id\"=\"${google_monitoring_uptime_check_config.portail_prod.uptime_check_id}\""
      comparison      = "COMPARISON_GT"
      threshold_value = 1
      duration        = "0s"

      aggregations {
        alignment_period     = "300s" # fenetre de 5 min : laisse le temps a un rollout normal de finir
        per_series_aligner   = "ALIGN_NEXT_OLDER"
        cross_series_reducer = "REDUCE_COUNT_FALSE"
      }
    }
  }

  notification_channels = [google_monitoring_notification_channel.email.name]
}

# Isole les erreurs applicatives de foodtrack-prod (aussi utilise par le dashboard).
resource "google_logging_metric" "erreurs_prod" {
  name   = "foodtrack-${var.equipe}-erreurs-prod"
  filter = "resource.type=\"k8s_container\" AND resource.labels.namespace_name=\"foodtrack-prod\" AND severity>=ERROR"

  metric_descriptor {
    metric_kind = "DELTA"
    value_type  = "INT64"
  }
}

resource "google_monitoring_dashboard" "foodtrack_prod" {
  dashboard_json = jsonencode({
    displayName = "FoodTrack - Production"
    mosaicLayout = {
      columns = 12
      tiles = [
        {
          width = 6, height = 4
          widget = {
            title = "CPU (foodtrack-prod)"
            xyChart = {
              dataSets = [{
                timeSeriesQuery = { timeSeriesFilter = {
                  filter      = "metric.type=\"kubernetes.io/container/cpu/core_usage_time\" AND resource.type=\"k8s_container\" AND resource.labels.namespace_name=\"foodtrack-prod\""
                  aggregation = { alignmentPeriod = "60s", perSeriesAligner = "ALIGN_RATE" }
                } }
                plotType = "LINE"
              }]
            }
          }
        },
        {
          xPos = 6, width = 6, height = 4
          widget = {
            title = "Memoire (foodtrack-prod)"
            xyChart = {
              dataSets = [{
                timeSeriesQuery = { timeSeriesFilter = {
                  filter      = "metric.type=\"kubernetes.io/container/memory/used_bytes\" AND resource.type=\"k8s_container\" AND resource.labels.namespace_name=\"foodtrack-prod\""
                  aggregation = { alignmentPeriod = "60s", perSeriesAligner = "ALIGN_MEAN" }
                } }
                plotType = "LINE"
              }]
            }
          }
        },
        {
          yPos = 4, width = 6, height = 4
          widget = {
            title = "Erreurs applicatives"
            xyChart = {
              dataSets = [{
                timeSeriesQuery = { timeSeriesFilter = {
                  filter      = "metric.type=\"logging.googleapis.com/user/${google_logging_metric.erreurs_prod.name}\""
                  aggregation = { alignmentPeriod = "300s", perSeriesAligner = "ALIGN_SUM" }
                } }
                plotType = "STACKED_BAR"
              }]
            }
          }
        },
        {
          xPos = 6, yPos = 4, width = 6, height = 4
          widget = {
            title = "Latence du portail"
            xyChart = {
              dataSets = [{
                timeSeriesQuery = { timeSeriesFilter = {
                  filter      = "metric.type=\"monitoring.googleapis.com/uptime_check/request_latency\" AND resource.type=\"uptime_url\" AND metric.label.\"check_id\"=\"${google_monitoring_uptime_check_config.portail_prod.uptime_check_id}\""
                  aggregation = { alignmentPeriod = "60s", perSeriesAligner = "ALIGN_MEAN" }
                } }
                plotType = "LINE"
              }]
            }
          }
        },
      ]
    }
  })
}
