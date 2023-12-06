pipeline "get_user" {
  title       = "Get User"
  description = "Get details about an existing user."

  param "cred" {
    type        = string
    description = local.cred_param_description
    default     = var.default_cred
  }

  param "user_id" {
    type        = string
    description = local.user_id_param_description
  }

  step "http" "get_user" {
    method = "GET"
    url    = "https://api.pagerduty.com/users/${param.user_id}"

    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Token token=${credential.pagerduty[param.cred].token}"
    }
  }

  output "user" {
    description = "The user requested."
    value       = step.http.get_user.response_body.user
  }
}
