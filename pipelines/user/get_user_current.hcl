// usage: flowpipe pipeline run get_user_current --pipeline-arg "user_login=me"
pipeline "get_user_current" {
  description = "Get the details of current auhhenticated user."

  param "token" {
    type    = string
    default = var.token
  }

  param "user_login" {
    type = string
  }

  step "http" "get_user_current" {
    method = "post"
    url    = "https://api.pagerduty.com/graphql"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Bearer ${param.token}"
    }

    request_body = jsonencode({
      query = <<EOQ
        query {
          user {
            nodes {
              id
              name
              email
              role
            }
          }
        }
        EOQ
    })
  }

  output "user_id" {
    value = jsondecode(step.http.get_user_current.response_body).data.user.id
  }
  output "response_body" {
    value = step.http.get_user_current.response_body
  }
  output "response_headers" {
    value = step.http.get_user_current.response_headers
  }
  output "status_code" {
    value = step.http.get_user_current.status_code
  }

}
