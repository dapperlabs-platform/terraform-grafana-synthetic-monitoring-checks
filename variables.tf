# https://registry.terraform.io/providers/grafana/grafana/latest/docs/resources/synthetic_monitoring_check

variable "dns_targets" {
  description = "List of endpoints to create DNS checks for"
  type        = list(string)
  default     = []
}

variable "http_targets" {
  description = "List of endpoints to create HTTP checks for"
  type        = list(string)
  default     = []
}

variable "probe_names" {
  description = "List of probe names used by the check"
  type        = list(string)
  default     = []
}

variable "alert_sensitivity" {
  type        = string
  description = "Recording rule sensisitivity label. One of none, low, medium, high."
  default     = "low"
}

variable "basic_metrics_only" {
  description = "Metrics are reduced by default. Set this to false if you'd like to publish all metrics"
  type        = bool
  default     = false
}

variable "enabled" {
  description = "Whether to enable the check"
  type        = bool
  default     = true
}

variable "frequency" {
  description = "How often the check runs in milliseconds"
  type        = number
  default     = 60000
}

variable "labels" {
  description = "Job labels"
  type        = map(string)
  default     = {}
}

variable "timeout" {
  description = "How long to wait before failing"
  type        = number
  default     = 3000
}

variable "dns_record_type" {
  description = "One of ANY, A, AAAA, CNAME, MX, NS, PTR, SOA, SRV, TXT"
  type        = string
  default     = "A"
}

variable "http_valid_status_codes" {
  description = "Valid response HTTP status codes"
  type        = list(number)
  default     = [200]
}

variable "http_no_follow_redirects" {
  description = "Do not follow redirects"
  type        = bool
  default     = false
}

variable "disable_probes" {
  description = "List of Probes to disable from synthetic monitoring checks"
  type        = list(string)
  default     = []
}
