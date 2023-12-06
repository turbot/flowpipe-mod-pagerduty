pipeline "list_users" {
  title       = "List Users"
  description = "List users of your PagerDuty account."

  param "cred" {
    type        = string
    description = local.cred_param_description
    default     = var.default_cred
  }

  step "http" "list_users" {
    method = "GET"
    url    = "https://api.pagerduty.com/users?limit=100"

    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Token token=${credential.pagerduty[param.cred].token}"
    }

    loop {
      until = result.response_body.more == false
      url   = "https://api.pagerduty.com/users?limit=100&offset=${loop.index + 1}"
    }
  }

  output "users" {
    description = "An array of users."
    value       = flatten([for page, users in step.http.list_users : users.response_body.users])
  }
}
