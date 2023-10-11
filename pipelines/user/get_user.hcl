// usage: flowpipe pipeline run get_user --pipeline-arg user_id="...."
pipeline "get_user" {
  description = "Get the details of a user by ID."

  param "token" {
    type    = string
    default = var.token
  }

  param "user_id" {
    type    = string
  }

  step "http" "get_user" {
    method = "GET"
    url    = "https://api.pagerduty.com/users/${param.user_id}"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Token token=${param.token}"
    }
  }

  output "user" {
    value = jsondecode(step.http.get_user.response_body)
  }
  output "user_id" {
    value = jsondecode(step.http.get_user.response_body).user.id
  }
  output "user_name" {
    value = jsondecode(step.http.get_user.response_body).user.name
  }
}
