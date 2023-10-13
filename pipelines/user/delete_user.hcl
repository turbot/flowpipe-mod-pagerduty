pipeline "delete_user" {
  title = "Delete user"
  description = "Delete an user given an ID."

  param "token" {
    type    = string
    description = "Token to make an API call."
    default = var.token
  }

  param "id" {
    type    = string
    description = "The ID of the resource."
  }

  step "http" "delete_user" {
    method = "DELETE"
    url    = "https://api.pagerduty.com/users/${param.id}"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Token token=${param.token}"
    }
  }

  output "delete_response" {
    value = step.http.delete_user.status_code
  }
}
