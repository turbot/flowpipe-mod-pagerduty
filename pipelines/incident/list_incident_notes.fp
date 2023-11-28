pipeline "list_incident_notes" {
  title       = "List Incident Notes"
  description = "List existing notes for the specified incident."

  param "api_key" {
    type        = string
    description = local.api_key_param_description
    default     = var.api_key
  }

  param "incident_id" {
    type        = string
    description = local.incident_id_param_description
  }

  step "http" "list_incident_notes" {
    method = "GET"
    url    = "https://api.pagerduty.com/incidents/${param.incident_id}/notes"

    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Token token=${param.api_key}"
    }
  }

  output "incident_notes" {
    description = "An array of notes."
    value       = step.http.list_incident_notes.response_body.notes
  }
}
