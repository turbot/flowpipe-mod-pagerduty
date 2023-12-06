pipeline "create_user" {
  title       = "Create User"
  description = "Create a new user."

  param "cred" {
    type        = string
    description = local.cred_param_description
    default     = var.default_cred
  }

  param "email" {
    type        = string
    description = "The user's email address."
  }

  param "name" {
    type        = string
    description = "The name of the user."
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

  param "job_title" {
    type        = string
    description = "The user's title."
    optional    = true
  }

  param "license" {
    type        = object
    description = "The License assigned to the user."
    optional    = true
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

  step "http" "create_user" {
    method = "POST"
    url    = "https://api.pagerduty.com/users"

    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Token token=${credential.pagerduty[param.cred].token}"
    }

    request_body = jsonencode({
      user = {
        for name, value in param : try(local.user_common_param[name], name) => value if contains(keys(local.user_common_param), name) && value != null
      }
    })
  }

  output "user" {
    description = "The user that was created."
    value       = step.http.create_user.response_body.user
  }
}
