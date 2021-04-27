terraform {
  required_version = ">= 0.14.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region     = "us-east-1"
}

## Data
data "aws_vpc" "this" {
  default = true
}

## Variables
variable "ssh_private_key_path" {
  description = "SSH private key file path"
  default     = "~/.ssh/id_rsa"
}

variable "ssh_public_key_path" {
  description = "SSH public key file path"
  default     = "~/.ssh/id_rsa.pub"
}

variable "ssh_username" {
  description = "Default username built into the AMI"
  default     = "ubuntu"
}

## Resources
# Create an SSH key pair for accessing the EC2 instance
resource "aws_key_pair" "this" {
  public_key = file(var.ssh_public_key_path)
}

# Create our default security group to access the instance, over specific protocols
resource "aws_security_group" "this" {
  vpc_id = data.aws_vpc.this.id
}

resource "aws_security_group_rule" "outgoing_any" {
  security_group_id = aws_security_group.this.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "incoming_ssh" {
  security_group_id = aws_security_group.this.id
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_instance" "this" {
  instance_type          = "t2.nano"
  ami                    = "ami-0ddbdea833a8d2f0d"
  key_name               = aws_key_pair.this.id                            # the name of the SSH keypair to use for provisioning
  vpc_security_group_ids = [aws_security_group.this.id]

  connection {
    host        = aws_instance.this.public_ip
    user        = var.ssh_username
    private_key = file(var.ssh_private_key_path)
    agent       = false                                    # don't use SSH agent because we have the private key right here
  }

  provisioner "remote-exec" {
    inline = [
      "echo ${aws_instance.this.ami}"
    ]
  }
}
