pipeline "list_on_calls" {
  title       = "List On-Calls"
  description = "List all the on-call entries."

  param "conn" {
    type        = connection.pagerduty
    description = local.conn_param_description
    default     = connection.pagerduty.default
  }

  step "http" "list_on_calls" {
    method = "GET"
    url    = "https://api.pagerduty.com/oncalls?limit=100"

    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Token token=${param.conn.token}"
    }

    loop {
      until = result.response_body.more == false
      url   = "https://api.pagerduty.com/oncalls?limit=100&offset=${loop.index + 1}"
    }
  }

  output "on_calls" {
    description = "An array of on-call objects."
    value       = flatten([for page, on_calls in step.http.list_on_calls : on_calls.response_body.oncalls])
  }
}
