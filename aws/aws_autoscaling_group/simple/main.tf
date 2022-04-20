

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
      cs_terraform_examples = "aws_autoscaling_group/simple"
    }
  }
}

# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami
# Explanation: Get most_recent version of Ubuntu Image 
data "aws_ami" "changeme_aws_ami" {
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

# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template
resource "aws_launch_template" "changeme_aws_launch_template" {
  name_prefix   = "changeme-aws-launch-template"
  image_id      = data.aws_ami.changeme_aws_ami.id
  instance_type = "t2.micro"
}

# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group
resource "aws_autoscaling_group" "changeme_aws_autoscaling_group" {
  availability_zones = ["us-east-1a"]
  desired_capacity   = 1
  max_size           = 2
  min_size           = 1

  launch_template {
    id      = aws_launch_template.changeme_aws_launch_template.id
    version = "$Latest"
  }
}