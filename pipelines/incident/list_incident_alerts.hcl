pipeline "list_incident_alerts" {
  title       = "List Incident Alerts"
  description = "List incident alerts in Pagerduty."

  param "api_key" {
    type        = string
    description = "API Key to make an API call."
    default     = var.api_key
  }

  param "incident_id" {
    type        = string
    description = "The ID of the resource."
  }

  step "http" "list_incident_alerts" {
    method = "GET"
    url    = "https://api.pagerduty.com/incidents/${param.incident_id}/alerts"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Token token=${param.api_key}"
    }
  }

  output "incident_alerts" {
    value = jsondecode(step.http.list_incident_alerts.response_body)
  }

}
