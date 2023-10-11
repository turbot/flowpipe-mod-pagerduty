// usage: flowpipe pipeline run create_user --pipeline-arg name="Earline Greenholt" --pipeline-arg email="125.greenholt.earline@graham.name" --pipeline-arg time_zone="America/Lima" --pipeline-arg color="red"  --pipeline-arg role="admin"  --pipeline-arg description="I'm the boss" --pipeline-arg job_title="Director of Engineering"
pipeline "create_user" {
  description = "Create a new user."

  param "token" {
    type    = string
    default = var.token
  }

  param "name" {
    // Limit <= 100 characters
    type    = string
  }

  param "email" {
    // Limit >=6 characters <=100 characters
    type    = string
  }

  param "time_zone" {
    // The preferred time zone name. Ex. America/Lima. If null, the account's time zone will be used.
    type    = string
    default = ""
  }

  param "color" {
    type    = string
    default = ""
  }

  param "role" {
    // Allowed values [admin, limited_user, observer, owner, read_only_user, restricted_access, read_only_limited_user, user]
    type    = string
    default = ""
  }

  param "description" {
    type    = string
    default = ""
  }

  param "job_title" {
    // Limit <=100 characters
    type    = string
    default = ""
  }


  step "http" "create_user" {
    method = "POST"
    url    = "https://api.pagerduty.com/users"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Token token=${param.token}"
    }
    request_body = jsonencode({
      user = {
        name = "${param.name}",
        email = "${param.email}",
        time_zone = "${param.time_zone}",
        color = "${param.color}",
        role = "${param.role}",
        description = "${param.description}",
        job_title = "${param.job_title}"
      }
    })
  }

  output "user" {
    value = jsondecode(step.http.create_user.response_body)
  }
  output "user_id" {
    value = jsondecode(step.http.create_user.response_body).user.id
  }
  output "user_name" {
    value = jsondecode(step.http.create_user.response_body).user.name
  }
}
