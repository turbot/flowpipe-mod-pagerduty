pipeline "list_incidents" {
  title = "List Incidents"
  description = "List incidents in Pagerduty."

  param "token" {
    type    = string
    description = "Token to make an API call."
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
