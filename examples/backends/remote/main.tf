# Summary: template for remote backend

# Documentation: https://www.terraform.io/docs/language/providers/requirements.html
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.42.0"
    }
  }
  # Documentation: https://www.terraform.io/docs/language/settings/backends/remote.html
  backend "remote" {
    organization = "changeme-terraform-examples"

    workspaces {
      # Documentation: https://www.terraform.io/docs/cloud/workspaces/naming.html
      name = "changeme-terraform-examples-workspace"
    }
  }
}

# Documentation: https://www.terraform.io/docs/language/providers/requirements.html
provider "aws" {
  region = "us-east-1"
  # Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags
  default_tags {
    tags = {
      cs_terraform_examples = "backends/remote"
    }
  }
}

# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc
resource "aws_vpc" "changeme_aws_vpc_remote_backend" {
  cidr_block = "10.1.0.0/16"
}
