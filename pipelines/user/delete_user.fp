pipeline "delete_user" {
  title       = "Delete User"
  description = "Remove an existing user."

  param "api_key" {
    type        = string
    description = local.api_key_param_description
    default     = var.api_key
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
      Authorization = "Token token=${param.api_key}"
    }
  }

}
