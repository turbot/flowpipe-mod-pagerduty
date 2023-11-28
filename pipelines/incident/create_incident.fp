pipeline "create_incident" {
  title       = "Create Incident"
  description = "Create an incident."

  param "api_key" {
    type        = string
    description = local.api_key_param_description
    default     = var.api_key
  }

  param "service" {
    type = object({
      id   = string
      type = string
    })
    description = "The service detail for the incident."
  }

  param "title" {
    type        = string
    description = "A succinct description of the nature, symptoms, cause, or effect of the incident."
  }

  param "from" {
    type        = string
    description = local.email_param_description
  }

  // Allowed value: incident
  param "type" {
    type        = string
    description = "The type of the incident."
    default     = "incident"
  }

  param "body" {
    type = object({
      type    = string
      details = string
    })
    description = "Additional incident details."
    optional    = true
  }

  param "conference_bridge" {
    type = object({
      conference_number = string
      conference_url    = string
    })
    description = "Central channel for collaboration."
    optional    = true
  }

  param "escalation_policy" {
    type = object({
      id   = string
      type = string
    })
    description = "The escalation policy for the incident."
    optional    = true
  }

  param "incident_key" {
    type        = string
    description = "A string which identifies the incident. Sending subsequent requests referencing the same service and with the same incident_key will result in those requests being rejected if an open incident matches that incident_key."
    optional    = true
  }

  param "priority" {
    type = object({
      id   = string
      type = string
    })
    description = "The priority of the incident."
    optional    = true
  }

  param "urgency" {
    type        = string
    description = "The urgency of the incident."
    optional    = true
  }

  step "http" "create_incident" {
    method = "POST"
    url    = "https://api.pagerduty.com/incidents"

    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Token token=${param.api_key}"
      From          = "${param.from}"
    }

    request_body = jsonencode({
      incident = {
        for name, value in param : name => value if value != null
      }
    })
  }

  output "incident" {
    description = "The created incident."
    value       = step.http.create_incident.response_body.incident
  }
}