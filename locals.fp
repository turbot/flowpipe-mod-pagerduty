locals {
  user_common_param = {
    name        = "name"
    email       = "email"
    time_zone   = "time_zone"
    color       = "color"
    role        = "role"
    description = "description"
    job_title   = "job_title"
  }
}

# Common descriptions
locals {
  api_key_param_description     = "The API token to authenticate to the PagerDuty APIs."
  email_param_description       = "The email address of a valid user associated with the account making the request."
  incident_id_param_description = "The ID of the incident."
  user_id_param_description     = "The ID of the user."
}
