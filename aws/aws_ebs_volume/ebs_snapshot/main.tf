# Summary: Create a Snapshot for a Given EBS Volume 

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
      cs_terraform_examples = "aws_ebs_volume/ebs_snapshot"
    }
  }
}

# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones
data "aws_availability_zones" "changeme_az_list_ebs_snapshot" {
  state = "available"
}


# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ebs_volume
# Explanation: The AWS 'aws_ebs_volume' resource is responsible for creating the EBS volume. The only required field is Availability Zone
# where the EBS vol is going to be created. Some optional arguments are Size in GBi, encryption(TRUE/FALSE) and he type of EBS volume. Can be "standard", "gp2", "io1", "sc1" or "st1" (Default: "standard").
resource "aws_ebs_volume" "changeme_ebs_volume_snapshot" {
  availability_zone = data.aws_availability_zones.changeme_az_list_ebs_snapshot.names[0]
  size              = 10
  type              = "standard"
  encrypted         = false
  tags = {
    Name = "changeme_ebs_volume_tag"
  }
}

# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ebs_snapshot
# Explanation: Takes a Snapshot from the EBS Volume created Above 
resource "aws_ebs_snapshot" "changeme_ebs_snapshot" {
  volume_id = aws_ebs_volume.changeme_ebs_volume_snapshot.id

  tags = {
    Name = "Hello_CS_snap"
  }
}
