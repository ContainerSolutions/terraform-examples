terraform {
  required_version = ">= 0.14.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "aws_resource_count" {
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
