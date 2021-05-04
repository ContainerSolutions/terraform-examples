terraform {
  required_version = ">= 0.14.0"
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "aws_vpc_for" {
  count = 3
  cidr_block = format("172.%d.0.0/16", 16 + count.index)
}

output "ips" {
  value = [
    for vpc in aws_vpc.aws_vpc_for:
      vpc.cidr_block
  ]
}
