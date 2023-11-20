pipeline "list_users" {
  title       = "List Users"
  description = "List users in pagerduty."

  param "api_key" {
    type        = string
    description = local.api_key_param_description
    default     = var.api_key
  }

  step "http" "list_users" {
    method = "GET"
    url    = "https://api.pagerduty.com/users"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Token token=${param.api_key}"
    }
  }

  output "users" {
    value = step.http.list_users.response_body
  }
}
