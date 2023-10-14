pipeline "delete_user" {
  title       = "Delete User"
  description = "Delete an user given an ID."

  param "api_key" {
    type        = string
    description = "API Key to make an API call."
    default     = var.api_key
  }

  param "user_id" {
    type        = string
    description = "The ID of the resource."
  }

  step "http" "delete_user" {
    method = "DELETE"
    url    = "https://api.pagerduty.com/users/${param.user_id}"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Token token=${param.api_key}"
    }
  }

  output "delete_response" {
    value = step.http.delete_user.status_code
  }
}
