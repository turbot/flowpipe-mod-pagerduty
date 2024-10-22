pipeline "snooze_incident" {
  title       = "Snooze Incident"
  description = "Snooze an incident."

  param "conn" {
    type        = connection.pagerduty
    description = local.conn_param_description
    default     = connection.pagerduty.default
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
      Authorization = "Token token=${param.conn.token}"
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
