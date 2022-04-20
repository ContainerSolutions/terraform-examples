
# Summary: Create a simple Autoscaling Group

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
  region  = "us-east-1"
  profile = "terraform-examples"
  default_tags {
    tags = {
      cs_terraform_examples = "aws_autoscaling_group/launch_configuration"
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

# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami
# Explanation: Get most_recent version of Ubuntu Image 
data "aws_ami" "changeme_aws_ami_lc" {
  most_recent = true

  # Explanation: Canonical now publishes  official Ubuntu images on the Amazon cloud.
  # Check supported versions here : https://uec-images.ubuntu.com/locator/
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-hirsute-21.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  # Explanation: There are different Public providers (owners), like Canonical, AWS and others . Check here: https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/finding-an-ami.html
  # Some examples of owners:   099720109477 - Canonical and 679593333241 - AWS
  owners = ["099720109477"]
}

# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/launch_configuration
resource "aws_launch_configuration" "changeme_aws_launch_configuration" {
  name_prefix   = "changeme-"
  image_id      = data.aws_ami.changeme_aws_ami.id
  instance_type = "t2.micro"

  lifecycle {
    create_before_destroy = true
  }
}

# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group
resource "aws_autoscaling_group" "changeme_aws_autoscaling_group_lc" {
  name                 = "changeme-aws-autoscaling-group"
  launch_configuration = aws_launch_configuration.changeme_aws_launch_configuration.name
  min_size             = 1
  max_size             = 2
  vpc_zone_identifier  = data.aws_subnet_ids.changeme_aws_subnet_ids.ids

  lifecycle {
    create_before_destroy = true
  }
}

