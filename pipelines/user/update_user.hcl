pipeline "update_user" {
  title       = "Update User"
  description = "Update an existing user."

  param "api_key" {
    type        = string
    description = local.api_key_param_description
    default     = var.api_key
  }

  param "user_id" {
    type        = string
    description = local.user_id_param_description
  }

  param "color" {
    type        = string
    description = "The schedule color."
    optional    = true
  }

  param "description" {
    type        = string
    description = "The user's bio."
    optional    = true
  }

  param "email" {
    type        = string
    description = "The user's email address."
  }

  param "job_title" {
    type        = string
    description = "The user's title."
    optional    = true
  }

  param "license" {
    type        = object
    description = "The license assigned to the user."
    optional    = true
  }

  param "name" {
    type        = string
    description = "The name of the user."
  }

  param "role" {
    type        = string
    description = "The user role. Account must have the read_only_users ability to set a user as a read_only_user or a read_only_limited_user, and must have advanced permissions abilities to set a user as observer or restricted_access."
    optional    = true
  }

  param "time_zone" {
    type        = string
    description = "The preferred time zone name. If null, the account's time zone will be used."
    optional    = true
  }

  step "http" "update_user" {
    method = "PUT"
    url    = "https://api.pagerduty.com/users/${param.user_id}"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Token token=${param.api_key}"
    }
    request_body = jsonencode({
      user = {
        for name, value in param : name => value if value != null
      }
    })
  }

  output "update_user" {
    value = step.http.update_user.response_body
  }
}
