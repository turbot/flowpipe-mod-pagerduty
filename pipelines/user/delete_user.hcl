// usage: flowpipe pipeline run delete_user --pipeline-arg user_id="...."
pipeline "delete_user" {
  description = "Delete an existing user by ID."

  param "token" {
    type    = string
    default = var.token
  }

  param "user_id" {
    type    = string
  }

  step "http" "delete_user" {
    method = "DELETE"
    url    = "https://api.pagerduty.com/users/${param.user_id}"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Token token=${param.token}"
    }
  }

  output "delete_response" {
    value = step.http.delete_user.status_code
  }
}
