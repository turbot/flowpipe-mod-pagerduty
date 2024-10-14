pipeline "create_incident" {
  title       = "Create Incident"
  description = "Create an incident."

  tags = {
    type = "featured"
  }

  param "conn" {
    type        = connection.pagerduty
    description = local.conn_param_description
    default     = connection.pagerduty.default
  }

  param "service_id" {
    type        = string
    description = "The ID of the service."
  }

  param "service_type" {
    type        = string
    description = "The type of the service."
  }

  param "title" {
    type        = string
    description = "A succinct description of the nature, symptoms, cause, or effect of the incident."
  }

  param "from" {
    type        = string
    description = local.email_param_description
  }

  param "body" {
    type        = string
    description = "Additional incident details."
    optional    = true
  }

  param "body_type" {
    type        = string
    description = "The type of the body."
    optional    = true
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

  param "incident_key" {
    type        = string
    description = "A string which identifies the incident. Sending subsequent requests referencing the same service and with the same incident_key will result in those requests being rejected if an open incident matches that incident_key."
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

  param "urgency" {
    type        = string
    description = "The urgency of the incident. Allowed values are 'high' and 'low'."
    optional    = true
  }

  step "http" "create_incident" {
    method = "POST"
    url    = "https://api.pagerduty.com/incidents"

    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Token token=${param.conn.token}"
      From          = "${param.from}"
    }

    request_body = jsonencode({
      incident = merge({
        type  = "incident"
        title = param.title
        service = {
          id   = param.service_id
          type = param.service_type
        }
        },
        param.body_type != null && param.body != null ? {
          body = {
            type    = param.body_type
            details = param.body
          }
        } : {},
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
        param.incident_key != null ? {
          incident_key = param.incident_key
        } : {},
        param.urgency != null ? {
          urgency = param.urgency
      } : {})
    })
  }

  output "incident" {
    description = "The created incident."
    value       = step.http.create_incident.response_body.incident
  }
}
