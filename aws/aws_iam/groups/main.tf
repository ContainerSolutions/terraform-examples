# Summary: Create a two users in two groups

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
      cs_terraform_examples = "aws_iam/groups"
    }
  }
}

# Documentation: https://www.terraform.io/docs/language/values/variables.html
variable "changeme_iam_groups_groups" {
  type = list(any)
  default = [
    "Dev",
    "Infra"
  ]
}

# Documentation: https://www.terraform.io/docs/language/values/variables.html
variable "changeme_iam_groups_users" {
  type = map(any)
  default = {
    "jane.doe" = {
      "groups" = [
        "Dev"
      ],
    },
    "john.doe" = {
      "groups" = [
        "Infra"
      ],
    }
  }
}

# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group
resource "aws_iam_group" "changeme_iam_groups_groups" {
  count = length(var.changeme_iam_groups_groups)
  name  = var.changeme_iam_groups_groups[count.index]
}

# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_policy_attachment
resource "aws_iam_group_policy_attachment" "changeme_iam_group_policy_attachment_administrators" {
  group      = aws_iam_group.changeme_iam_groups_groups[1].name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_policy
resource "aws_iam_group_policy" "changeme_iam_group_policy_dev" {
  name   = "changeme-iam-group-policy-dev"
  group  = aws_iam_group.changeme_iam_groups_groups[1].id
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

# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_policy
resource "aws_iam_group_policy" "changeme_iam_group_policy_dev_assumerole" {
  name   = "changeme-iam-group-policy-devsecops-assumerole"
  group  = aws_iam_group.changeme_iam_groups_groups[1].id
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

# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user
resource "aws_iam_user" "changeme_iam_user_users" {
  for_each = var.changeme_iam_groups_users
  name     = each.key
}

# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_group_membership
resource "aws_iam_user_group_membership" "changeme_iam_user_group_membership_user_groups" {
  for_each = var.changeme_iam_groups_users
  user     = each.key
  groups   = each.value["groups"]
  # This manual dependency is required, else Terraform complains the users do not exist yet.
  depends_on = [
    aws_iam_user.changeme_iam_user_users,
    aws_iam_group.changeme_iam_groups_groups
  ]
}

