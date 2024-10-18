pipeline "get_user" {
  title       = "Get User"
  description = "Get details about an existing user."

  tags = {
    recommended = "true"
  }

  param "conn" {
    type        = connection.pagerduty
    description = local.conn_param_description
    default     = connection.pagerduty.default
  }

  param "user_id" {
    type        = string
    description = local.user_id_param_description
  }

  step "http" "get_user" {
    method = "GET"
    url    = "https://api.pagerduty.com/users/${param.user_id}"

    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Token token=${param.conn.token}"
    }
  }

  output "user" {
    description = "The user requested."
    value       = step.http.get_user.response_body.user
  }
}
