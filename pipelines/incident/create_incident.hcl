// usage: flowpipe pipeline run create_incident --pipeline-arg type="incident" --pipeline-arg title="The server is on fire." --pipeline-arg service="America/Lima" --pipeline-arg color="red"  --pipeline-arg role="admin"  --pipeline-arg description="I'm the boss" --pipeline-arg job_title="Director of Engineering"
pipeline "create_incident" {
  description = "Create a new incident."

  param "token" {
    type    = string
    default = var.token
  }

  param "from" {
    type = string
  }

  param "type" {
    type    = string
  }

  param "title" {
    type    = string
  }

  param "service_id" {
    type    = string
  }

  param "service_type" {
    type    = string
  }

  param "priority_id" {
    type    = string
    default = ""
  }

  param "priority_type" {
    type    = string
    default = ""
  }

  // Allowed values [high, low]
  param "urgency" {
    type =  string
    default = "high"
  }

  param "incident_key" {
    type = string
    default = ""
  }

  param "body_details" {
    type    = string
    default = ""
  }

  param "body_type" {
    type    = string
    default = ""
  }

  param "escalation_policy_id" {
    type = string
    default = ""
  }

  param "escalation_policy_type" {
    type = string
    default = ""
  }

  param "conference_bridge_conference_number" {
    type = string
    default = ""
  }

  param "conference_bridge_conference_url" {
    type = string
    default = ""
  }

  step "http" "create_incident" {
    method = "POST"
    url    = "https://api.pagerduty.com/incidents"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Token token=${param.token}"
      From = "${param.from}"
    }
    request_body = jsonencode({
      incident = {
        type = "${param.type}",
        title = "${param.title}",
        service = {
            id = "${param.service_id}",
            type = "${param.service_type}"
        },
        priority = length("${param.priority_id}") > 0 || length("${param.priority_type}") > 0 ? {
          id   = "${param.priority_id}",
          type = "${param.priority_type}"
        } : {},
        urgency = "${param.urgency}",
        incident_key = "${param.incident_key}",
        body = {
            type = "${param.body_type}",
            details = "${param.body_details}",
        },
        escalation_policy = length("${param.escalation_policy_id}") > 0 || length("${param.escalation_policy_type}") > 0 ? {
          id   = "${param.escalation_policy_id}",
          type = "${param.escalation_policy_type}"
        } : {},
        conference_bridge = {
            conference_url = "${param.conference_bridge_conference_url}",
            conference_number = "${param.conference_bridge_conference_number}"
        }
      }
    })
  }

  output "incident" {
    value = jsondecode(step.http.create_incident.response_body)
  }

}
