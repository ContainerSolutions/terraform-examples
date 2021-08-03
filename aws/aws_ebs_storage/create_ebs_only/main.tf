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

# Documentation: https://www.terraform.io/docs/language/values/variables.html
variable "changeme_ebs_volume_size" {
  description = "Size of the EBS volume in GiBs. Defaults to 10"
  type = number
  default = 10
}

variable "changeme_ebs_volume_region" {
  description = "AZ where the EBS volume will exist. Defaults to us-east-1"
  type = string
  default = "us-east-1a"
}

# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group
resource "aws_ebs_volume" "changeme_ebs_volume" {
  
  availability_zone = var.changeme_ebs_volume_region
  size              = var.changeme_ebs_volume_size 
  tags = {
    Name = "changeme_ebs_volume_object"
  }
}