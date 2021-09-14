# Summary: Remote execution using default expected location of your ssh keys,
# and setup of provider connection.
#
# Note: assumes you have a keypair set up in the location specified in
#       `changeme_aws_instance_simple_ssh_access_ssh_private_key_path.default` below.
#       This has been set to a useful default of `~/.ssh/id_rsa`.
#       You can retrieve the public IP address by looking at the output of `terraform show`,
#       eg `terraform show | grep public_ip`.
#       You should then be able to log in with, eg: `ssh -i ~/.ssh/id_rsa ubuntu@<<PUBLIC IP ADDRESS>>`.

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
      cs_terraform_examples = "aws_instance/simple_ssh_access"
    }
  }
}

# Documentation: https://www.terraform.io/docs/language/data-sources/index.html
data "aws_vpc" "changeme_aws_simple_ssh_access_vpc_default" {
  default = true
}

# Documentation: https://www.terraform.io/docs/language/values/variables.html
variable "changeme_aws_instance_simple_ssh_access_ssh_private_key_path" {
  description = "SSH private key file path"
  default     = "~/.ssh/id_rsa"
}

# Documentation: https://www.terraform.io/docs/language/values/variables.html
variable "changeme_aws_instance_simple_ssh_access_ssh_public_key_path" {
  description = "SSH public key file path"
  default     = "~/.ssh/id_rsa.pub"
}

# Documentation: https://www.terraform.io/docs/language/values/variables.html
variable "changeme_aws_instance_simple_ssh_access_ssh_username" {
  description = "Default username built into the AMI"
  default     = "ubuntu"
}

# Explanation: Create an SSH key pair for accessing the EC2 instance
#
# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair
resource "aws_key_pair" "changeme_simple_ssh_access_aws_key_pair" {
  public_key = file(var.changeme_aws_instance_simple_ssh_access_ssh_public_key_path)
}

# Explanation: Create our default security group to access the instance, over specific protocols
#
# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group
resource "aws_security_group" "changeme_simple_ssh_access_security_group" {
  vpc_id = data.aws_vpc.changeme_aws_simple_ssh_access_vpc_default.id
}

# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule
resource "aws_security_group_rule" "changeme_simple_ssh_access_security_group_rule_outgoing_any" {
  security_group_id = aws_security_group.changeme_simple_ssh_access_security_group.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule
resource "aws_security_group_rule" "changeme_simple_ssh_access_security_group_rule_incoming_ssh" {
  security_group_id = aws_security_group.changeme_simple_ssh_access_security_group.id
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance
resource "aws_instance" "changeme_simple_ssh_access_aws_instance" {
  # Documentation: https://www.terraform.io/docs/language/meta-arguments/count.html
  instance_type          = "t2.nano"
  ami                    = "ami-0ddbdea833a8d2f0d"
  key_name               = aws_key_pair.changeme_simple_ssh_access_aws_key_pair.id # the name of the SSH keypair to use for provisioning
  vpc_security_group_ids = [aws_security_group.changeme_simple_ssh_access_security_group.id]
}
