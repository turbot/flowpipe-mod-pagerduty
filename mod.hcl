mod "pagerduty" {
  title         = "PagerDuty"
  description   = "Run pipelines and triggers that interact with PagerDuty."
  color         = "#06AC38"
  documentation = file("./docs/index.md")
  icon          = "/images/flowpipe/mods/turbot/pagerduty.svg"
  categories    = ["pagerduty", "library"]

  opengraph {
    title       = "PagerDuty"
    description = "Run pipelines and triggers that interact with PagerDuty."
    image       = "/images/flowpipe/mods/turbot/pagerduty-social-graphic.png"
  }
}
