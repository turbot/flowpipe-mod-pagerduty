// usage: flowpipe pipeline run list_incidents
pipeline "list_incidents" {
  description = "Get the details of all incidents."

  param "token" {
    type    = string
    default = var.token
  }

  step "http" "list_incidents" {
    method = "GET"
    url    = "https://api.pagerduty.com/incidents"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Token token=${param.token}"
    }
  }

  output "incidents" {
    value = jsondecode(step.http.list_incidents.response_body).incidents
  }

  output "incidents_id" {
    value = jsondecode(step.http.list_incidents.response_body).incidents[*].id
  }

}
