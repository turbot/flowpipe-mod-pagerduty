pipeline "create_status_update_on_incident" {
  title       = "Create Status Update on Incident"
  description = "Create a new status update for the specified incident."

  param "api_key" {
    type        = string
    description = local.api_key_param_description
    default     = var.api_key
  }

  param "message" {
    type        = string
    description = "The message to be posted as a status update."
  }

  param "incident_id" {
    type        = string
    description = local.incident_id_param_description
  }

  param "from" {
    type        = string
    description = local.email_param_description
  }

  step "http" "create_status_update_on_incident" {
    method = "POST"
    url    = "https://api.pagerduty.com/incidents/${param.incident_id}/status_updates"

    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Token token=${param.api_key}"
      From          = "${param.from}"
    }

    request_body = jsonencode({
      message = param.message
    })
  }

  output "status_update" {
    description = "The new status update for the specified incident."
    value       = step.http.create_status_update_on_incident.response_body.status_update
  }
}