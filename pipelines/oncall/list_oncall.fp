pipeline "list_oncalls" {
  title       = "List On-Calls"
  description = "List all the on-call entries."

  param "api_key" {
    type        = string
    description = local.api_key_param_description
    default     = var.api_key
  }

  step "http" "list_oncalls" {
    method = "GET"
    url    = "https://api.pagerduty.com/oncalls?limit=100"

    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Token token=${param.api_key}"
    }

    loop {
      until = result.response_body.more == false
      url   = "https://api.pagerduty.com/oncalls?limit=100&offset=${loop.index + 1}"
    }
  }

  output "oncalls" {
    description = "An array of on-call objects."
    value       = flatten([for page, oncalls in step.http.list_oncalls : oncalls.response_body.oncalls])
  }
}
