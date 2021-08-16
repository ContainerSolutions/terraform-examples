# Summary: Creates the simplest VM instance

# Documentation: https://www.terraform.io/docs/language/settings/index.html
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    linode = {
      source  = "linode/linode"
      version = "~> 1.18.0"
    }
  }
}

provider "linode" {
}

# Compute Instance
# Documentation: https://registry.terraform.io/providers/linode/linode/latest/docs/resources/instance
resource "linode_instance" "changeme_linode_simple_instance" {
  label  = "changeme-linode-simple-instance"
  region = "us-east"
  type   = "g6-nanode-1"
  image  = "linode/ubuntu20.04"
}
