// usage: flowpipe pipeline run update_user --pipeline-arg name="Earline Greenholt" --pipeline-arg user_id="..."
pipeline "update_user" {
  description = "Update an user."

  param "token" {
    type    = string
    default = var.token
  }

  param "Accept" {
   type = string
   default = "application/vnd.pagerduty+json;version=2"
  }

  param "user_id" {
    type    = string
  }

  param "name" {
    // Limit <= 100 characters
    type    = string
  }

  step "http" "update_user" {
    method = "PUT"
    url    = "https://api.pagerduty.com/users/${param.user_id}"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Token token=${param.token}"
      Accept = "${param.Accept}"
    }
    request_body = jsonencode({
      user = {
        name = "${param.name}"
      }
    })
  }
}
