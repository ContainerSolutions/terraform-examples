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
  region     = "us-east-1"
}

resource "aws_instance" "aws_resource_count" {
  count         = 2
  instance_type = "t2.nano"
  ami           = "ami-0ddbdea833a8d2f0d"
}
