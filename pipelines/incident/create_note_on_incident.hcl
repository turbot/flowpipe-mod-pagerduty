pipeline "create_note_on_incident" {
  title       = "Create Note on Incident"
  description = "Create a note on an incident."

  param "content" {
    type        = string
    description = "The note content of the incident."
  }

  param "incident_id" {
    type        = string
    description = "The ID of the incident."
  }

  param "from" {
    type        = string
    description = "The email address of a valid user associated with the account making the request."
  }

  param "api_key" {
    type        = string
    description = "API Key to make an API call."
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
