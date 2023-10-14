pipeline "list_users" {
  title       = "List Users"
  description = "List users in pagerduty."

  param "api_key" {
    type        = string
    description = "API Key to make an API call."
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
    value = jsondecode(step.http.list_users.response_body).users
  }
  output "user_id" {
    value = jsondecode(step.http.list_users.response_body).users[*].id
  }
  output "user_name" {
    value = jsondecode(step.http.list_users.response_body).users[*].name
  }
}
