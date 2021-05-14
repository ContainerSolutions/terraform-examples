# Summary: Uses the 'count' feature to create multiple EC2 instances.

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

# Explanation: This resource is not necessary for the creation of an S3 bucket, but is here to ensure that
# the S3 bucket name is unique.
#
# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance
resource "aws_instance" "changeme_aws_resource_count" {
  # Documentation: https://www.terraform.io/docs/language/meta-arguments/count.html
  count         = 2
  instance_type = "t2.nano"
  ami           = "ami-0ddbdea833a8d2f0d"
}
