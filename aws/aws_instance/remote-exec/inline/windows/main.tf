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
  region = "us-east-1"
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

variable "admin" {
  description = "Default username built into the AMI"
  default     = "Administrator"
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

resource "aws_security_group_rule" "incoming_rdp" {
  security_group_id = aws_security_group.this.id
  type              = "ingress"
  from_port         = 3389
  to_port           = 3389
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "incoming_winrm" {
  security_group_id = aws_security_group.this.id
  type              = "ingress"
  from_port         = 5986
  to_port           = 5986
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_instance" "this" {
  instance_type          = "t2.micro"
  ami                    = "ami-0f93c815788872c5d"
  key_name               = aws_key_pair.this.id # the name of the SSH keypair to use for provisioning
  vpc_security_group_ids = [aws_security_group.this.id]
  user_data              = file("scripts/user_data.txt")
  get_password_data      = true
  tags                   = { Name = "terraform-smaples" }
}

output "admin_password" {
  value = rsadecrypt(aws_instance.this.password_data, file(var.ssh_private_key_path))
}

resource "null_resource" "provision_files" {

  connection {
    host     = aws_instance.this.public_ip
    type     = "winrm"
    user     = "Administrator"
    password = rsadecrypt(aws_instance.this.password_data, file(var.ssh_private_key_path))
    https    = true
    insecure = true
    port     = 5986
    timeout  = "1m"
  }

  provisioner "file" {
    source      = "scripts/hello.ps1"
    destination = "C:/hello.ps1"
  }

  provisioner "remote-exec" {
    inline = [
      "powershell.exe -ExecutionPolicy Bypass -File C:/hello.ps1"
    ]
  }
}