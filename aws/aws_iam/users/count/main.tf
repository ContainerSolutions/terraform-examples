# Summary: Uses the 'count' feature to create multiple IAM users.

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
      cs_terraform_examples = "aws_iam/users/count"
    }
  }
}

# Documentation: https://www.terraform.io/docs/language/values/variables.html
variable "users_count" {
  default = "2"
}

# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user
resource "aws_iam_user" "changeme_iam_user" {
  count = var.users_count
  name  = "changeme-iam-user-name-${count.index}"
}

# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_access_key
resource "aws_iam_access_key" "changeme_iam_user" {
  count = var.users_count
  user  = aws_iam_user.changeme_iam_user[count.index].name
}

# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_policy
resource "aws_iam_user_policy" "changeme_iam_group_policy_admin" {
  count = var.users_count
  name  = "changeme-iam-group-policy-admin-${count.index}"
  user  = aws_iam_user.changeme_iam_user[count.index].name

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
