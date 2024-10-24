mod "pagerduty" {
  title         = "PagerDuty"
  description   = "Run pipelines to supercharge your PagerDuty workflows using Flowpipe."
  color         = "#06AC38"
  documentation = file("./README.md")
  icon          = "/images/mods/turbot/pagerduty.svg"
  categories    = ["library", "incident response"]

  opengraph {
    title       = "PagerDuty Mod for Flowpipe"
    description = "Run pipelines to supercharge your PagerDuty workflows using Flowpipe."
    image       = "/images/mods/turbot/pagerduty-social-graphic.png"
  }

  require {
    flowpipe {
      min_version = "1.0.0"
    }
  }
}
