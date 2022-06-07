
# Summary: Create an EFS in AWS 

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
      cs_terraform_examples = "aws_efs/simple"
    }
  }
}

# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc
data "aws_vpc" "changeme_default_aws_vpc" {
  default = true
}

# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet_ids
data "aws_subnet_ids" "changeme_aws_subnet_ids" {
  vpc_id = data.aws_vpc.changeme_default_aws_vpc.id
}

# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group
resource "aws_security_group" "changeme_efs_aws_security_group" {
  name        = "changeme-simple-efs-security-group"
  description = "Allow inbound traffic"
  ingress {
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_file_system
resource "aws_efs_file_system" "changeme_aws_efs" {
  performance_mode = "generalPurpose"
  throughput_mode  = "bursting"
  encrypted        = "false"
  kms_key_id       = null

  tags = {
    Name = "changeme-simple-efs"
  }

  lifecycle_policy {
    transition_to_ia = "AFTER_30_DAYS"
  }
}

# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_mount_target
resource "aws_efs_mount_target" "changeme_efs_mount_target" {
  for_each        = data.aws_subnet_ids.changeme_aws_subnet_ids.ids
  subnet_id       = each.value
  file_system_id  = aws_efs_file_system.changeme_aws_efs.id
  security_groups = [aws_security_group.changeme_efs_aws_security_group.id]
}
