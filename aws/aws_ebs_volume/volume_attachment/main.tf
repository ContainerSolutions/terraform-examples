# Summary: Create an EBS volume in AWS and attach to EC2 instance

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
      cs_terraform_examples = "aws_ebs_volume/volume_attachment"
    }
  }
}

# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones
data "aws_availability_zones" "changeme_az_list" {
  state = "available"
}


# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/volume_attachment
# Explanation: Provide the attachment between the extra EBS external volume and the Ec2 Instance 
resource "aws_volume_attachment" "changeme_aws_volume_attachment" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.changeme_aws_ebs_volume.id
  instance_id = aws_instance.changeme_aws_instance.id
}


# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ebs_volume
# Explanation: The AWS 'aws_ebs_volume' resource is responsible for creating the EBS volume. The only required field is Availability Zone
# where the EBS vol is going to be created. Some optional arguments are Size in GBi, encryption(TRUE/FALSE) and he type of EBS volume. Can be "standard", "gp2", "io1", "sc1" or "st1" (Default: "standard").
resource "aws_ebs_volume" "changeme_aws_ebs_volume" {
  availability_zone = data.aws_availability_zones.changeme_az_list.names[0]
  size              = 5
  type              = "standard"
  encrypted         = false
  tags = {
    Name = "changeme_ebs_volume_tag"
  }
}

# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance
# Explanation: The AWS 'aws_instance' resource is responsible for allocating an EC2 instance. It's needed as we want to deliver the 
# the EBS volume to it. 
resource "aws_instance" "changeme_aws_instance" {
  instance_type = "t2.micro"

  # Explanation: AMI IDs are region-specific. This AMI ID is specific to the `us-east-1` region. If you use a different region, you will need to change this ID.
  ami               = "ami-0c2b8ca1dad447f8a" # us-east-1 / Amazon Linux
  availability_zone = data.aws_availability_zones.changeme_az_list.names[0]
  tags = {
    Name = "changeme_aws_instance_tag"
  }
  user_data = <<-EOF
            #!/bin/bash
            echo "Hello_Example!"
            EOF
}

