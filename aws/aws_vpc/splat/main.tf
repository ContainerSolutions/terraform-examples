# Summary: Uses the 'count' feature to create multiple EC2 instances.
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
      cs_terraform_examples = "aws_vpc/splat"
    }
  }
}

# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc
resource "aws_vpc" "changeme_aws_vpc_splat" {
  # Documentation: # Documentation: https://www.terraform.io/docs/language/meta-arguments/count.html
  count      = 3
  cidr_block = format("172.%d.0.0/16", 16 + count.index)
}

# Documentation: https://www.terraform.io/docs/language/values/outputs.html
output "changeme_cidr_block_full_splat" {
  # Documentation: https://www.terraform.io/docs/language/expressions/splat.html
  value = aws_vpc.changeme_aws_vpc_splat[*].cidr_block
}
