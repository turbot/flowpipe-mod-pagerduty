pipeline "snooze_incident" {
  title       = "Snooze Incident"
  description = "Snooze an incident."

  param "api_key" {
    type        = string
    description = local.api_key_param_description
    default     = var.api_key
  }

  param "from" {
    type        = string
    description = local.email_param_description
  }

  param "duration" {
    type        = number
    description = "The number of seconds to snooze the incident for. After this number of seconds has elapsed, the incident will return to the triggered state."
  }

  param "incident_id" {
    type        = string
    description = local.incident_id_param_description
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

  output "snooze_incident" {
    value = step.http.snooze_incident.response_body
  }
}
