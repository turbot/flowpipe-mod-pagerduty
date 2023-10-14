pipeline "get_user" {
  title       = "Get User by ID"
  description = "Get an user by its ID."

  param "api_key" {
    type        = string
    description = "API Key to make an API call."
    default     = var.api_key
  }

  param "user_id" {
    type        = string
    description = "The ID of the resource."
  }

  step "http" "get_user" {
    method = "GET"
    url    = "https://api.pagerduty.com/users/${param.user_id}"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Token token=${param.api_key}"
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
