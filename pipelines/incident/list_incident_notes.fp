pipeline "list_incident_notes" {
  title       = "List Incident Notes"
  description = "List existing notes for the specified incident."

  param "cred" {
    type        = string
    description = local.cred_param_description
    default     = var.default_cred
  }

  param "incident_id" {
    type        = string
    description = local.incident_id_param_description
  }

  step "http" "list_incident_notes" {
    method = "GET"
    url    = "https://api.pagerduty.com/incidents/${param.incident_id}/notes?limit=100"

    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Token token=${credential.pagerduty[param.cred].token}"
    }

    loop {
      until = result.response_body.more == false
      url   = "https://api.pagerduty.com/incidents/${param.incident_id}/notes?limit=100&offset=${loop.index + 1}"
    }
  }

  output "notes" {
    description = "An array of notes."
    value       = flatten([for page, notes in step.http.list_incident_notes : notes.response_body.notes])
  }
}
