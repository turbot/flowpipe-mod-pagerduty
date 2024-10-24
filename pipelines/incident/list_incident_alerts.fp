pipeline "list_incident_alerts" {
  title       = "List Incident Alerts"
  description = "List alerts for the specified incident."

  param "conn" {
    type        = connection.pagerduty
    description = local.conn_param_description
    default     = connection.pagerduty.default
  }

  param "incident_id" {
    type        = string
    description = local.incident_id_param_description
  }

  step "http" "list_incident_alerts" {
    method = "GET"
    url    = "https://api.pagerduty.com/incidents/${param.incident_id}/alerts?limit=100"

    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Token token=${param.conn.token}"
    }

    loop {
      until = result.response_body.more == false
      url   = "https://api.pagerduty.com/incidents/${param.incident_id}/alerts?limit=100&offset=${loop.index + 1}"
    }
  }

  output "alerts" {
    description = "An array of the incident's alerts."
    value       = flatten([for page, alerts in step.http.list_incident_alerts : alerts.response_body.alerts])
  }
}
