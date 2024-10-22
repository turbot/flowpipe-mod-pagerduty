pipeline "update_user" {
  title       = "Update User"
  description = "Update an existing user."

  param "conn" {
    type        = connection.pagerduty
    description = local.conn_param_description
    default     = connection.pagerduty.default
  }

  param "name" {
    type        = string
    description = "The name of the user."
  }

  param "email" {
    type        = string
    description = "The user's email address."
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

  param "job_title" {
    type        = string
    description = "The user's title."
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

  step "pipeline" "get_user" {
    pipeline = pipeline.get_user
    args = {
      conn    = param.conn
      user_id = param.user_id
    }
  }

  step "http" "update_user" {
    depends_on = [step.pipeline.get_user]

    method = "PUT"
    url    = "https://api.pagerduty.com/users/${param.user_id}"

    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Token token=${param.conn.token}"
    }

    request_body = jsonencode({
      user = {
        avatar_url  = step.pipeline.get_user.output.user.avatar_url
        color       = coalesce(param.color, step.pipeline.get_user.output.user.color)
        description = coalesce(param.description, step.pipeline.get_user.output.user.description)
        email       = coalesce(param.email, step.pipeline.get_user.output.user.email)
        job_title   = step.pipeline.get_user.output.user.job_title
        name        = coalesce(param.name, step.pipeline.get_user.output.user.name)
        role        = step.pipeline.get_user.output.user.role
        time_zone   = step.pipeline.get_user.output.user.time_zone
        type        = step.pipeline.get_user.output.user.type
      }
    })
  }

  output "user" {
    description = "The user that was updated."
    value       = step.http.update_user.response_body.user
  }
}
