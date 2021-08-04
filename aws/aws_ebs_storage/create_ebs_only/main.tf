# Summary: Create an EBS volume in AWS 

# Documentation: https://www.terraform.io/docs/language/settings/index.html
terraform {
  required_version = ">= 0.14.0"
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
      cs_terraform_examples = "aws_ebs_storage/create_ebs_only"
    }
  }
}

# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ebs_volume
# Explanation: The AWS 'aws_ebs_volume' resource is responsible for creating the EBS volume. The only required field is Availability Zone
# where the EBS is going to be created. It's also good to set the Size in GBi. 
#
resource "aws_ebs_volume" "changeme_ebs_volume" {
  availability_zone = "us-east-2a"
  size              = 10
  tags = {
    Name = "changeme_ebs_volume_object"
  }
}