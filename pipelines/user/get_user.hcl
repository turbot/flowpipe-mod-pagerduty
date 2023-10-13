pipeline "get_user" {
  title = "Get user by ID"
  description = "Get an user by its ID."

  param "token" {
    type    = string
    description = "Token to make an API call."
    default = var.token
  }

  param "id" {
    type    = string
    description = "The ID of the resource."
  }

  step "http" "get_user" {
    method = "GET"
    url    = "https://api.pagerduty.com/users/${param.id}"
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
