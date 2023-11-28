pipeline "list_incident_log_entries" {
  title       = "List Incident Log Entries"
  description = "List log entries for the specified incident."

  param "api_key" {
    type        = string
    description = local.api_key_param_description
    default     = var.api_key
  }

  param "incident_id" {
    type        = string
    description = local.incident_id_param_description
  }

  step "http" "list_incident_log_entries" {
    method = "GET"
    url    = "https://api.pagerduty.com/incidents/${param.incident_id}/log_entries"

    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Token token=${param.api_key}"
    }
  }

  output "incident_log_entries" {
    description = "An array of the incident's log entries."
    value       = step.http.list_incident_log_entries.response_body
  }
}