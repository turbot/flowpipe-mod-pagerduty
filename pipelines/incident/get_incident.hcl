pipeline "get_incident" {
  title       = "Get Incident"
  description = "Get incident in Pagerduty."

  param "api_key" {
    type        = string
    description = "API Key to make an API call."
    default     = var.api_key
  }

  param "incident_id" {
    type        = string
    description = "The ID of the resource."
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
    value = step.http.get_incident.response_body
  }
}
