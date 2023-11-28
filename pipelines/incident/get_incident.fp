pipeline "get_incident" {
  title       = "Get Incident"
  description = "Show detailed information about an incident."

  param "api_key" {
    type        = string
    description = local.api_key_param_description
    default     = var.api_key
  }

  param "incident_id" {
    type        = string
    description = local.incident_id_param_description
  }

  step "http" "get_incident" {
    method = "GET"
    url    = "https://api.pagerduty.com/incidents/${param.incident_id}"

    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Token token=${param.api_key}"
    }
  }

  output "incident" {
    description = "The incident requested."
    value       = step.http.get_incident.response_body.incident
  }
}
