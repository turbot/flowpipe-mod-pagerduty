// usage: flowpipe pipeline run get_current_user
pipeline "get_current_user" {
  description = "Get the details of current auhhenticated user. Require user-level access token."

  // Require user-level access token for getting authenticated user.
  param "token" {
    type    = string
    default = var.token
  }

  step "http" "get_current_user" {
    method = "GET"
    url    = "https://api.pagerduty.com/users/me"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Token token=${param.token}"
    }
  }

  output "user" {
    value = jsondecode(step.http.get_current_user.response_body)
  }
  output "user_id" {
    value = jsondecode(step.http.get_current_user.response_body).user.id
  }
  output "user_name" {
    value = jsondecode(step.http.get_current_user.response_body).user.name
  }
}
