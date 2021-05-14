# Summary: Simplest example of an aws_instance resource

# Documentation: https://www.terraform.io/docs/language/settings/index.html
terraform {
  required_version = ">= 0.14.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Documentation: https://www.terraform.io/docs/language/providers/requirements.html
provider "aws" {
  region = "us-east-1"
}

# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance
resource "aws_instance" "changeme_aws_resource_simple" {
  instance_type = "t2.nano"
  ami           = "ami-0ddbdea833a8d2f0d"
}
