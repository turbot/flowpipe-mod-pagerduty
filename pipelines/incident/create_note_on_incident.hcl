pipeline "create_note_on_incident" {
  title       = "Create Note on Incident"
  description = "Create a note on an incident."

  param "content" {
    type        = string
    description = "The note content of the incident."
  }

  param "incident_id" {
    type        = string
    description = local.incident_id_param_description
  }

  param "from" {
    type        = string
    description = local.email_param_description
  }

  param "api_key" {
    type        = string
    description = local.api_key_param_description
    default     = var.api_key
  }

  step "http" "create_note_on_incident" {
    method = "POST"
    url    = "https://api.pagerduty.com/incidents/${param.incident_id}/notes"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Token token=${param.api_key}"
      From          = "${param.from}"
    }
    request_body = jsonencode({
      note = {
        content = param.content
      }
    })
  }

  output "create_note_on_incident" {
    value = step.http.create_note_on_incident.response_body
  }
}
