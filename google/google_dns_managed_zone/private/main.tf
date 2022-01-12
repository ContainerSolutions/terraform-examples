# Summary: Creates a private DNS managed zone

# Documentation: https://www.terraform.io/docs/language/settings/index.html
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 3.0"
    }
  }
}

# Documentation: https://www.terraform.io/docs/language/providers/requirements.html
provider "google" {
  project = var.project_id
  region  = "us-central1"
  zone    = "us-central1-a"
}

# Documentation: https://www.terraform.io/docs/language/values/variables.html
variable "project_id" {
  type = string
}

# DNS Managed Zone
# Documentation: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/dns_managed_zone
resource "google_dns_managed_zone" "changeme_private_zone" {
  name       = "changeme-private-zone"
  dns_name   = "changeme-private-zone.com."
  visibility = "private"
}
