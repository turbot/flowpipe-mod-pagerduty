pipeline "update_incident" {
  title       = "Update Incident"
  description = "Update an incident."

  param "conference_bridge" {
    type = object({
      conference_number = string
      conference_url    = string
    })
    description = "Details of the conference bridge."
    optional    = true
  }

  param "escalation_level" {
    type        = number
    description = "Escalate the incident to this level in the escalation policy."
    optional    = true
  }

  param "escalation_policy" {
    type        = object({})
    description = "The escalation policy for the incident."
    optional    = true
  }

  param "from" {
    type        = string
    description = local.email_param_description
    optional    = true
  }

  param "incident_id" {
    type        = string
    description = local.incident_id_param_description
  }

  param "priority" {
    type = object({
      id   = string
      type = string
    })
    description = "The priority of the incident."
    optional    = true
  }

  param "resolution" {
    type        = string
    description = "The resolution for this incident if status is set to resolved."
    optional    = true
  }

  param "status" {
    type        = string
    description = "The new status of the incident."
    optional    = true
  }

  param "api_key" {
    type        = string
    description = local.api_key_param_description
    default     = var.api_key
  }

  param "title" {
    type        = string
    description = "The new title of the incident."
    optional    = true
  }

  param "type" {
    type        = string
    description = "The incident type."
  }

  param "urgency" {
    type        = string
    description = "The urgency of the incident."
    optional    = true
  }

  step "http" "update_incident" {
    method = "PUT"
    url    = "https://api.pagerduty.com/incidents/${param.incident_id}"
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

  output "update_incident" {
    value = step.http.update_incident.response_body
  }
}
