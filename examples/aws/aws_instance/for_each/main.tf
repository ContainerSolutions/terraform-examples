# Summary: Example of 'for_each' usage.

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
      cs_terraform_examples = "aws_instance/for_each"
    }
  }
}

# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance
resource "aws_instance" "changeme_aws_instance_count_foreach" {
  # Documentation: https://www.terraform.io/docs/language/meta-arguments/for_each.html
  for_each = {
    "a" = "1"
    "b" = "2"
  }

  tags = {
    Name = "aws_resource_count_${each.key}${each.value}"
  }
  instance_type = "t2.nano"
  ami           = "ami-0ddbdea833a8d2f0d"
}
