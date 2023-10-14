pipeline "list_incident_alert" {
  title = "List Incidents"
  description = "List incidents in Pagerduty."

  param "token" {
    type    = string
    description = "Token to make an API call."
    default = var.token
  }

  param "id" {
    type    = string
    description = "The ID of the resource."
  }

  step "http" "list_incident_alert" {
    method = "GET"
    url    = "https://api.pagerduty.com/incidents/${param.id}/alerts"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Token token=${param.token}"
    }
  }

  output "incident_alert" {
    value = jsondecode(step.http.list_incident_alert.response_body)
  }

}
