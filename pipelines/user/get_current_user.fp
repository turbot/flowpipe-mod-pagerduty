pipeline "get_current_user" {
  title       = "Get Current User"
  description = "Get details about the current user. Requires use a user-level token."

  param "cred" {
    type        = string
    description = local.cred_param_description
    default     = "default"
  }

  step "http" "get_current_user" {
    method = "GET"
    url    = "https://api.pagerduty.com/users/me"

    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Token token=${credential.pagerduty[param.cred].token}"
    }
  }

  output "user" {
    description = "The requesting user."
    value       = step.http.get_current_user.response_body.user
  }
}
