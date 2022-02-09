# Summary: Create an IAM user with IAM access key to allow API requests to be made as an IAM user.

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
      cs_terraform_examples = "aws_iam/users"
    }
  }
}

# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user
resource "aws_iam_user" "changeme_iam_user" {
  name = "changeme-iam-user-name"
}

# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_access_key
resource "aws_iam_access_key" "changeme_iam_user" {
  user = aws_iam_user.changeme_iam_user.name
}

# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_policy
resource "aws_iam_user_policy" "changeme_iam_group_policy_admin" {
  name = "changeme-iam-group-policy-admin"
  user = aws_iam_user.changeme_iam_user.name

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "*",
      "Resource": "*"
    }
  ]
}
EOF
}
