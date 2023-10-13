pipeline "update_incident" {
  title = "Update incident by ID"
  description = "Update an user by its ID."

  param "conference_bridge" {
    type        = object({
      conference_number = string
      conference_url    = string
    })
    description = "Details of the conference bridge."
    optional    = true
  }

  param "escalation_level" {
    type = number
    description = "Escalate the incident to this level in the escalation policy."
    optional = true
  }

  param "escalation_policy" {
    type = object({})
    description = "The escalation policy for the incident."
    optional = true
  }

  param "from" {
    type = string
    description = "The email address of a valid user associated with the account making the request."
    optional = true
  }

  param "id" {
    type    = string
    description = "The ID of the resource."
  }

  param "priority" {
    type        = object({
      id   = string
      type = string
    })
    description = "The priority of the incident."
    optional    = true
  }

  param "resolution" {
    type = string
    description = "The resolution for this incident if status is set to resolved."
    optional = true
  }

  param "status" {
    type = string
    description = "The new status of the incident."
    optional = true
  }

  param "token" {
    type    = string
    description = "Token to make an API call."
    default = var.token
  }

  param "title" {
    type = string
    description = "The new title of the incident."
    optional = true
  }

  param "type" {
    type = string
    description = ""
  }

  param "urgency" {
    type     = string
    description = "The urgency of the incident."
    optional = true
  }
  
  step "http" "update_incident" {
    method = "PUT"
    url    = "https://api.pagerduty.com/incidents/${param.id}"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Token token=${param.token}"
      From          = "${param.from}"
    }
    request_body = jsonencode({
      incident = {
        for name, value in param : name => value if value != null
      }
    })
  }

  output "update_response" {
    value = jsondecode(step.http.update_incident.response_body)
  }
}
