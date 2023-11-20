pipeline "create_user" {
  title       = "Create User"
  description = "Create an user."

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
    description = "The License assigned to the user."
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

  param "api_key" {
    type        = string
    description = local.api_key_param_description
    default     = var.api_key
  }

  step "http" "create_user" {
    method = "POST"
    url    = "https://api.pagerduty.com/users"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Token token=${param.api_key}"
    }
    request_body = jsonencode({
      user = {
        name        = "${param.name}",
        email       = "${param.email}",
        time_zone   = "${param.time_zone}",
        color       = "${param.color}",
        role        = "${param.role}",
        description = "${param.description}",
        job_title   = "${param.job_title}"
      }
    })
  }

  output "user" {
    value = step.http.create_user.response_body
  }
}
