# TODO: Should these have defaults?
# Right now they do due to :
# panic: missing 2 variable values:
# repository_full_name not set
# token not set

variable "repository_full_name" {
  type        = string
  description = "The full name of the GitHub repository. Examples: turbot/steampipe, turbot/flowpipe"
  default     = "cbruno10/github-api-test"
}

variable "token" {
  type        = string
  description = "The PagerDuty personal access token to authenticate to the PagerDuty APIs, e.g., `u+gLkyUh9sGsEGH3nmtw`. Please see https://support.pagerduty.com/docs/api-access-keys for more information."
  default     = ""
}
