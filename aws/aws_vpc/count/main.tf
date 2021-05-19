# Summary: Example of 'for' block

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

# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc
resource "aws_vpc" "aws_vpc_count" {
  count      = 3
  cidr_block = format("172.%d.0.0/16", 16 + count.index)
}

# Documentation: https://www.terraform.io/docs/language/values/outputs.html
output "cidr_block_full_splat" {
  value = aws_vpc.aws_vpc_count[*].cidr_block
}

# Documentation: https://www.terraform.io/docs/language/values/outputs.html
output "ips" {
  # Documentation: https://www.terraform.io/docs/language/expressions/for.html
  value = [
    for vpc in aws_vpc.aws_vpc_count :
    vpc.cidr_block
  ]
}
