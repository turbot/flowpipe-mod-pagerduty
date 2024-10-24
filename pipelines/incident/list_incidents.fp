pipeline "list_incidents" {
  title       = "List Incidents"
  description = "List existing incidents."

  param "conn" {
    type        = connection.pagerduty
    description = local.conn_param_description
    default     = connection.pagerduty.default
  }

  step "http" "list_incidents" {
    method = "GET"
    url    = "https://api.pagerduty.com/incidents?limit=100"

    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Token token=${param.conn.token}"
    }

    loop {
      until = result.response_body.more == false
      url   = "https://api.pagerduty.com/incidents?limit=1&offset=${loop.index + 1}"
    }
  }

  output "incidents" {
    description = "An array of incidents."
    value       = flatten([for page, incidents in step.http.list_incidents : incidents.response_body.incidents])
  }
}
