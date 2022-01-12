# Summary: Data Source for getting latest getting AMI Linux Imagehttps://docs.aws.amazon.com/AWSEC2/latest/UserGuide/finding-an-ami.html

# Documentation: https://www.tserraform.io/docs/language/settings/index.html
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
      cs_terraform_examples = "aws_instance/ami_lookup"
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

# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance
resource "aws_instance" "changeme_ami_lookup_aws_instance" {
  ami           = data.aws_ami.changeme_aws_ami.id
  instance_type = "t3.micro"

  tags = {
    Name = "changeme_ami_lookup_aws_instance"
  }
}
