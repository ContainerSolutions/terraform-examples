# Summary: Create an S3 bucket

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

# Documentation: https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id
resource "random_id" "changeme_bucket_name" {
  byte_length = 16
}

# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket
resource "aws_s3_bucket" "changeme_aws_s3_bucket_simple" {
  bucket = "te-${random_id.changeme_bucket_name.hex}"
}
