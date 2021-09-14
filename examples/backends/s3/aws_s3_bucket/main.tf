# Summary: Creates an S3 bucket in AWS with a unique name.

# Documentation: https://www.terraform.io/docs/language/settings/index.html
terraform {
  required_version = ">= 1.0.0"
}

# Documentation: https://www.terraform.io/docs/language/providers/requirements.html
provider "aws" {
  region = "us-east-1"
}

# Explanation: This resource is not necessary for the creation of an S3 bucket, but is here to ensure that
# the S3 bucket name is unique.
#
# Documentation: https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id
resource "random_id" "changeme_backends_s3_bucket_name" {
  byte_length = 16
}

# Explanation: This is the resource that creates the bucket.
#
# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket
resource "aws_s3_bucket" "changeme_aws_s3_bucket_backend_simple" {
  force_destroy = true
  bucket        = "changeme-${random_id.changeme_backends_s3_bucket_name.hex}"
}
