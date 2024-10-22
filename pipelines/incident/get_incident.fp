pipeline "get_incident" {
  title       = "Get Incident"
  description = "Show detailed information about an incident."

  tags = {
    recommended = "true"
  }

  param "conn" {
    type        = connection.pagerduty
    description = local.conn_param_description
    default     = connection.pagerduty.default
  }

  param "incident_id" {
    type        = string
    description = local.incident_id_param_description
  }

  step "http" "get_incident" {
    method = "GET"
    url    = "https://api.pagerduty.com/incidents/${param.incident_id}"

    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Token token=${param.conn.token}"
    }
  }

  output "incident" {
    description = "The incident requested."
    value       = step.http.get_incident.response_body.incident
  }
}
