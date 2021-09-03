# Summary: Uses 'dynamic' to create multiple 'ingress' blocks within an 'aws_security_group' resource.

# Documentation: https://www.terraform.io/docs/language/settings/index.html
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.38"
    }
  }
}

# Documentation: https://www.terraform.io/docs/language/providers/requirements.html
provider "aws" {
  region = "us-east-1"
  default_tags {
    tags = {
      cs_terraform_examples = "aws_security_group/dynamic"
    }
  }
}

# Documentation: https://www.terraform.io/docs/language/values/locals.html
locals {
  ports = [80, 443, 8080]
}

# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group
resource "aws_security_group" "changeme_aws_security_group_dynamic" {
  name = "changeme-aws-security-group-dynamic"

  # Documentation: https://www.terraform.io/docs/language/expressions/dynamic-blocks.html
  dynamic "ingress" {
    for_each = local.ports
    content {
      description = "changeme-aws-security-group-dynamic-ingress-${ingress.key}"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}
