# Summary: Creates the simplest VM instance

# Documentation: https://www.terraform.io/docs/language/settings/index.html
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.9.0"
    }
  }
}

# DigitalOcean Provider
# Documentation: https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs
provider "digitalocean" {
}

# Compute Instance
# Documentation: https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/droplet
resource "digitalocean_droplet" "changeme_digitalocean_simple_instance" {
  name       = "changeme-digitalocean-simple-instance"
  image      = "ubuntu-20-04-x64"
  region     = "nyc1"
  size       = "s-1vcpu-1gb"
  monitoring = true

  tags = [
    "cs_terraform_examples",
    "digitalocean_droplet-simple"
  ]
}
