locals {
  user_common_param = {
    color       = "color"
    description = "description"
    email       = "email"
    job_title   = "job_title"
    name        = "name"
    role        = "role"
    time_zone   = "time_zone"
  }
}

# Common descriptions
locals {
  api_key_param_description     = "The API token to authenticate to the PagerDuty APIs."
  email_param_description       = "The email address of a valid user associated with the account making the request."
  incident_id_param_description = "The ID of the incident."
  user_id_param_description     = "The ID of the user."
}
