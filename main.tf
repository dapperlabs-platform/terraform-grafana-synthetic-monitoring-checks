locals {
  deprecated_probes = [
    "Chicago",
    "LosAngeles",
    "Miami",
    "Seattle",
    "SanJose",
    "Seol"
  ]
  available_probes = { for k, v in data.grafana_synthetic_monitoring_probes.main.probes : k => v if contains(concat(var.disable_probes, local.deprecated_probes), k) == false }
  probes           = length(var.probe_names) > 0 ? [for k, v in local.available_probes : v if contains(var.probe_names, k)] : values(local.available_probes)
}

data "grafana_synthetic_monitoring_probes" "main" {}

resource "grafana_synthetic_monitoring_check" "http" {
  for_each = toset(var.http_targets)

  # replace . and / with - and remove query params
  job               = "${split("?", replace(each.value, "/[\\.\\/]/", "-"))[0]}-http"
  target            = "https://${each.value}"
  enabled           = var.enabled
  probes            = local.probes
  alert_sensitivity = var.alert_sensitivity
  timeout           = var.timeout
  labels            = var.labels

  settings {
    http {
      valid_status_codes  = var.http_valid_status_codes
      no_follow_redirects = var.http_no_follow_redirects
      method              = var.http_method
      body                = jsonencode(var.http_post_request_body)
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
