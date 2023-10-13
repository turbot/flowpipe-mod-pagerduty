pipeline "get_incident" {
  title = "Get Incident"
  description = "Get incident in Pagerduty."

  param "token" {
    type    = string
    description = "Token to make an API call."
    default = var.token
  }

  param "id" {
    type    = string
    description = "The ID of the resource."
  }

  step "http" "get_incident" {
    method = "GET"
    url    = "https://api.pagerduty.com/incidents/${param.id}"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Token token=${param.token}"
    }
  }

  output "incident" {
    value = jsondecode(step.http.get_incident.response_body).incident
  }
}
