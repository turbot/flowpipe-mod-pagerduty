pipeline "list_incidents" {
  title       = "List Incidents"
  description = "List existing incidents."

  param "api_key" {
    type        = string
    description = local.api_key_param_description
    default     = var.api_key
  }

  step "http" "list_incidents" {
    method = "GET"
    url    = "https://api.pagerduty.com/incidents"

    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Token token=${param.api_key}"
    }
  }

  output "incidents" {
    description = "An array of incidents."
    value       = step.http.list_incidents.response_body.incidents
  }
}
