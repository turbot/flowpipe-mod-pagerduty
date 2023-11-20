pipeline "list_incident_log_entries" {
  title       = "List Incident Log Entries"
  description = "List log entries for an incident."

  param "api_key" {
    type        = string
    description = "API Key to make an API call."
    default     = var.api_key
  }

  param "incident_id" {
    type        = string
    description = "The ID of the resource."
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
    value = step.http.list_incident_log_entries.response_body
  }

}
