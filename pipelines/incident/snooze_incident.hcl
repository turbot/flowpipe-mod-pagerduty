pipeline "snooze_incident" {
  title       = "Snooze Incident"
  description = "Snooze an incident."

  param "api_key" {
    type        = string
    description = "API Key to make an API call."
    default     = var.api_key
  }

  param "from" {
    type        = string
    description = "The email address of a valid user associated with the account making the request."
  }

  param "duration" {
    type        = number
    description = "The number of seconds to snooze the incident for. After this number of seconds has elapsed, the incident will return to the triggered state."
  }

  param "incident_id" {
    type        = string
    description = "The ID of the resource."
  }

  step "http" "snooze_incident" {
    method = "POST"
    url    = "https://api.pagerduty.com/incidents/${param.incident_id}/snooze"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Token token=${param.api_key}"
      From          = "${param.from}"
    }
    request_body = jsonencode({
      duration = param.duration
    })
  }

  output "snooze_response" {
    value = jsondecode(step.http.snooze_incident.response_body).snooze_response
  }
}
