pipeline "list_on_calls" {
  title       = "List On-Calls"
  description = "List all of the on-calls."

  param "api_key" {
    type        = string
    description = local.api_key_param_description
    default     = var.api_key
  }

  step "http" "list_on_calls" {
    method = "GET"
    url    = "https://api.pagerduty.com/oncalls"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Token token=${param.api_key}"
    }
  }

  output "on_calls" {
    value = step.http.list_on_calls.response_body
  }
}
