pipeline "list_users" {
  title = "List users"
  description = "List users in pagerduty."

  param "token" {
    type    = string
    description = "Token to make an API call."
    default = var.token
  }

  step "http" "list_users" {
    method = "GET"
    url    = "https://api.pagerduty.com/users"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Token token=${param.token}"
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
