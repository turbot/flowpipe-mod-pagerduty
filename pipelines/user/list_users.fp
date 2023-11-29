pipeline "list_users" {
  title       = "List Users"
  description = "List users of your PagerDuty account."

  param "api_key" {
    type        = string
    description = local.api_key_param_description
    default     = var.api_key
  }

  step "http" "list_users" {
    method = "GET"
    url    = "https://api.pagerduty.com/users?limit=100"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Token token=${param.api_key}"
    }

    loop {
      until = result.response_body.more == false
      url   = "https://api.pagerduty.com/users?limit=100&offset=${loop.index + 1}"
    }
  }

  output "users" {
    description = "A paginated array of users."
    value       = flatten([for page, users in step.http.list_users : users.response_body.users])
  }
}
