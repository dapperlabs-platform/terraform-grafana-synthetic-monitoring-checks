# Grafana Synthetic Monitoring Checks

https://registry.terraform.io/providers/grafana/grafana/latest/docs/resources/synthetic_monitoring_check

## What does this do?

This module creates Grafana synthetic monitoring jobs for the provided endpoints

## How to use this module?

```hcl
module "grafana-monitoring" {
  source = "github.com/dapperlabs-platform/terraform-grafana-synthetic-monitoring-checks?ref=tag"
  alert_sensitivity = "medium"
  labels = {
    "label"     = "value"
  }
  dns_targets = [
    "my.domain.com"
  ]
  dns_record_type = "CNAME"

  http_targets = [
    "my.domain.com"
  ]
  http_valid_status_codes = [403]
}
```

## Resources created

- Grafana Synthetic Monitoring Checks

## Requirements

Terraform >= 1.0.0

## Variables

| name                    | description                                                                            |     type     | required | default |
| ----------------------- | -------------------------------------------------------------------------------------- | :----------: | :------: | :-----: |
| dns_targets             | List of endpoints to create DNS checks for                                             | list(string) |          |   []    |
| http_targets            | List of endpoints to create HTTP checks for                                            | list(string) |          |   []    |
| probe_names             | List of probe names used by the check                                                  | list(string) |          |   []    |
| alert_sensitivity       | Recording rule sensisitivity label. One of none, low, medium, high.                    |    string    |          |   low   |
| basic_metrics_only      | Metrics are reduced by default. Set this to false if you'd like to publish all metrics |     bool     |          |  false  |
| enabled                 | Whether to enable the check                                                            |     bool     |          |  true   |
| frequency               | How often the check runs in milliseconds                                               |    number    |          |  60000  |
| labels                  | Job labels                                                                             | map(string)  |          |   {}    |
| timeout                 | How long to wait before failing                                                        |    number    |          |  3000   |
| dns_record_type         | One of ANY, A, AAAA, CNAME, MX, NS, PTR, SOA, SRV, TXT                                 |    string    |          |    A    |
| http_valid_status_codes | Valid response HTTP status codes                                                       | list(number) |          |  [200]  |
