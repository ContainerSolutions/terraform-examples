terraform {
  required_version = ">= 0.14.0"
}

provider "aws" {
  region = "us-east-1"
}

resource "random_id" "bucket_name" {
  byte_length = 16
}

resource "aws_s3_bucket" "aws_s3_bucket_simple" {
  bucket = "te-${random_id.bucket_name.hex}"
}
