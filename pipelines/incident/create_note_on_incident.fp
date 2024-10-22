pipeline "create_note_on_incident" {
  title       = "Create Note on Incident"
  description = "Create a new note for the specified incident."

  param "conn" {
    type        = connection.pagerduty
    description = local.conn_param_description
    default     = connection.pagerduty.default
  }

  param "content" {
    type        = string
    description = "The note content."
  }

  param "incident_id" {
    type        = string
    description = local.incident_id_param_description
  }

  param "from" {
    type        = string
    description = local.email_param_description
  }

  step "http" "create_note_on_incident" {
    method = "POST"
    url    = "https://api.pagerduty.com/incidents/${param.incident_id}/notes"

    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Token token=${param.conn.token}"
      From          = "${param.from}"
    }

    request_body = jsonencode({
      note = {
        content = param.content
      }
    })
  }

  output "note" {
    description = "The new note."
    value       = step.http.create_note_on_incident.response_body.note
  }
}
