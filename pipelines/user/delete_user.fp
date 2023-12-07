pipeline "delete_user" {
  title       = "Delete User"
  description = "Remove an existing user."

  param "cred" {
    type        = string
    description = local.cred_param_description
    default     = "default"
  }

  param "user_id" {
    type        = string
    description = local.user_id_param_description
  }

  step "http" "delete_user" {
    method = "DELETE"
    url    = "https://api.pagerduty.com/users/${param.user_id}"

    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Token token=${credential.pagerduty[param.cred].token}"
    }
  }

}
