terraform {
  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = "0.25.3"
    }
  }
}

resource "tfe_organization" "terraform-examples" {
  name  = "terraform-examples"
  email = "admin@company.com"
}

resource "tfe_workspace" "backends-remote-us-east" {
  name                  = "backends-remote-us-east"
  organization          = tfe_organization.terraform-examples.id
  file_triggers_enabled = false
  queue_all_runs        = false
  speculative_enabled   = false
}
