pipeline "list_incident_log_entries" {
  title       = "List Incident Log Entries"
  description = "List log entries for the specified incident."

  param "conn" {
    type        = connection.pagerduty
    description = local.conn_param_description
    default     = connection.pagerduty.default
  }

  param "incident_id" {
    type        = string
    description = local.incident_id_param_description
  }

  step "http" "list_incident_log_entries" {
    method = "GET"
    url    = "https://api.pagerduty.com/incidents/${param.incident_id}/log_entries?limit=100"

    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Token token=${param.conn.token}"
    }

    loop {
      until = result.response_body.more == false
      url   = "https://api.pagerduty.com/incidents/${param.incident_id}/log_entries?limit=100&offset=${loop.index + 1}"
    }
  }

  output "log_entries" {
    description = "An array of the incident's log entries."
    value       = flatten([for page, log_entries in step.http.list_incident_log_entries : log_entries.response_body.log_entries])
  }
}
