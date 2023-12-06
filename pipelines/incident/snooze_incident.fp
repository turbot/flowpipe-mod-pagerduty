pipeline "snooze_incident" {
  title       = "Snooze Incident"
  description = "Snooze an incident."

  param "cred" {
    type        = string
    description = local.cred_param_description
    default     = var.default_cred
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
      Authorization = "Token token=${credential.pagerduty[param.cred].token}"
      From          = "${param.from}"
    }
    request_body = jsonencode({
      duration = param.duration
    })
  }

  output "incident" {
    description = "The incident that was successfully snoozed."
    value       = step.http.snooze_incident.response_body.incident
  }
}
