pipeline "list_incident_notes" {
  title       = "List Incident Notes"
  description = "List existing notes for the specified incident."

  param "cred" {
    type        = string
    description = local.cred_param_description
    default     = "default"
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
      Authorization = "Token token=${credential.pagerduty[param.cred].token}"
    }
  }

  output "notes" {
    description = "An array of notes."
    value       = step.http.list_incident_notes.response_body.notes
  }
}
