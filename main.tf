locals {
  probes = length(var.probe_names) > 0 ? slice(sort(distinct([for k, v in data.grafana_synthetic_monitoring_probes.main.probes : contains(var.probe_names, k) ? v : 0])), 1, length(var.probe_names) + 1) : values(data.grafana_synthetic_monitoring_probes.main.probes)
}

data "grafana_synthetic_monitoring_probes" "main" {}

resource "grafana_synthetic_monitoring_check" "http" {
  for_each = toset(var.http_targets)

  job               = "${replace(each.value, ".", "-")}-http"
  target            = "https://${each.value}"
  enabled           = var.enabled
  probes            = local.probes
  alert_sensitivity = var.alert_sensitivity
  timeout           = var.timeout
  labels            = var.labels

  settings {
    http {
      valid_status_codes = var.http_valid_status_codes
    }
  }
}

resource "grafana_synthetic_monitoring_check" "dns" {
  for_each = toset(var.dns_targets)

  job               = "${replace(each.value, ".", "-")}-dns"
  target            = each.value
  enabled           = var.enabled
  probes            = local.probes
  labels            = var.labels
  alert_sensitivity = var.alert_sensitivity

  settings {
    dns {
      record_type = var.dns_record_type
    }
  }
}
