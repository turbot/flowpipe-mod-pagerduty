pipeline "list_incident_notes" {
  title       = "List Notes for Incident"
  description = "List notes for an incident."

  param "api_key" {
    type        = string
    description = "API Key to make an API call."
    default     = var.api_key
  }

  param "incident_id" {
    type        = string
    description = "The ID of the incident."
  }

  step "http" "list_incident_notes" {
    method = "GET"
    url    = "https://api.pagerduty.com/incidents/${param.incident_id}/notes"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Token token=${param.api_key}"
    }
  }

  output "list_incident_notes" {
    value = step.http.list_incident_notes.response_body
  }
}
