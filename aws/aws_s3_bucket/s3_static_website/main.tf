# Summary: Setup a static website inside the S3 Bucket 

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
      cs_terraform_examples = "aws_s3_bucket/s3_static_website"
    }
  }
}



# Documentation: https://www.terraform.io/docs/language/providers/requirements.html
# Explanation: Sets a Bucket for Static Website Hosting
# See also: [aws/aws_s3_bucket/simple] (https://github.com/ContainerSolutions/terraform-examples/tree/main/aws/aws_s3_bucket/simple)
resource "aws_s3_bucket" "changeme_aws_static_website" {
  bucket = "s3-website-xftcs.example.com"
  acl    = "public-read"
  policy = file("policy.json")
  website {
    index_document = "index.html"
    error_document = "error.html"

    routing_rules = <<EOF
[{
    "Condition": {
        "KeyPrefixEquals": "docs/"
    },
    "Redirect": {
        "ReplaceKeyPrefixWith": "documents/"
    }
}]
EOF
  }
}