pipeline "update_incident" {
  title       = "Update Incident"
  description = "Acknowledge, resolve, escalate or reassign an incident."

  param "cred" {
    type        = string
    description = local.cred_param_description
    default     = var.default_cred
  }

  param "incident_id" {
    type        = string
    description = local.incident_id_param_description
  }

  param "type" {
    type        = string
    description = "The incident type. Allowed values are 'incident' and 'incident_reference'"
  }

  param "from" {
    type        = string
    description = local.email_param_description
  }

  param "conference_number" {
    type        = string
    description = "The phone number of the conference call for the conference bridge."
    optional    = true
  }

  param "conference_url" {
    type        = string
    description = "An URL for the conference bridge. This could be a link to a web conference or Slack channel."
    optional    = true
  }

  param "escalation_level" {
    type        = number
    description = "Escalate the incident to this level in the escalation policy."
    optional    = true
  }

  param "escalation_policy_id" {
    type        = string
    description = "The ID of the escalation policy for the incident."
    optional    = true
  }

  param "escalation_policy_type" {
    type        = string
    description = "The type of the escalation policy for the incident."
    optional    = true
  }

  param "priority_id" {
    type        = string
    description = "The ID of the priority of the incident."
    optional    = true
  }

  param "priority_type" {
    type        = string
    description = "The type of the priority of the incident."
    optional    = true
  }

  param "resolution" {
    type        = string
    description = "The resolution for this incident if status is set to resolved."
    optional    = true
  }

  param "status" {
    type        = string
    description = "The new status of the incident. Allowed values are 'acknowledged' and 'resolved'."
    optional    = true
  }

  param "title" {
    type        = string
    description = "The new title of the incident."
    optional    = true
  }

  param "urgency" {
    type        = string
    description = "The urgency of the incident. Allowed values are 'high' and 'low'."
    optional    = true
  }

  step "http" "update_incident" {
    method = "PUT"
    url    = "https://api.pagerduty.com/incidents/${param.incident_id}"

    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Token token=${credential.pagerduty[param.cred].token}"
      From          = "${param.from}"
    }

    request_body = jsonencode({
      incident = merge({
        type  = param.type
        title = param.title
        },
        param.escalation_policy_id != null && param.escalation_policy_type != null ? {
          escalation_policy = {
            id   = param.escalation_policy_id
            type = param.escalation_policy_type
          }
        } : {},
        param.priority_id != null && param.priority_type != null ? {
          priority = {
            id   = param.priority_id
            type = param.priority_type
          }
        } : {},
        param.conference_number != null && param.conference_url != null ? {
          conference_bridge = {
            conference_number = param.conference_number
            conference_url    = param.conference_url
          }
        } : {},
        param.resolution != null ? {
          resolution = param.resolution
        } : {},
        param.status != null ? {
          status = param.status
        } : {},
        param.escalation_level != null ? {
          escalation_level = param.escalation_level
        } : {},
        param.urgency != null ? {
          urgency = param.urgency
      } : {})
    })
  }

  output "incident" {
    value = step.http.update_incident.response_body.incident
  }
}
