pipeline "get_current_user" {
  title       = "Get Current Authenticated User"
  description = "Get the details of current auhhenticated user."

  param "api_key" {
    type        = string
    description = "API Key to make an API call."
    default     = var.api_key
  }

  step "http" "get_current_user" {
    method = "GET"
    url    = "https://api.pagerduty.com/users/me"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Token token=${param.api_key}"
    }
  }

  output "user" {
    value = step.http.get_current_user.response_body
  }
}
