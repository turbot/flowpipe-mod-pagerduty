pipeline "list_incident_notes" {
  title       = "List Incident Notes"
  description = "List existing notes for the specified incident."

  param "conn" {
    type        = connection.pagerduty
    description = local.conn_param_description
    default     = connection.pagerduty.default
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
      Authorization = "Token token=${param.conn.token}"
    }
  }

  output "notes" {
    description = "An array of notes."
    value       = step.http.list_incident_notes.response_body.notes
  }
}
