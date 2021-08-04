# Summary: Run a command in a newly-created Windows machine

# Documentation: https://www.terraform.io/docs/language/settings/index.html
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
      cs_terraform_examples = "aws_instance/remote-exec/inline/windows"
    }
  }
}

# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc
data "aws_vpc" "changeme_aws_vpc" {
  default = true
}

# Documentation: https://www.terraform.io/docs/language/values/variables.html
variable "changeme_aws_instance_remote_exec_inline_windows_ssh_private_key_path" {
  description = "SSH private key file path"
  default     = "~/.ssh/id_rsa"
}

# Documentation: https://www.terraform.io/docs/language/values/variables.html
variable "changeme_aws_instance_remote_exec_inline_windows_ssh_public_key_path" {
  description = "SSH public key file path"
  default     = "~/.ssh/id_rsa.pub"
}

# Explanation: Create an SSH key pair for accessing the EC2 instance
#
# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair
resource "aws_key_pair" "changeme_remote_exec_inline_windows_key_pair" {
  public_key = file(var.changeme_aws_instance_remote_exec_inline_windows_ssh_public_key_path)
}

# Explanation: Create our default security group to access the instance, over specific protocols
#
# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group
resource "aws_security_group" "changeme_remote_exec_inline_windows_security_group" {
  vpc_id = data.aws_vpc.changeme_aws_vpc.id
}

# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule
resource "aws_security_group_rule" "changeme_remote_exec_inline_windows_security_group_rule_outgoing_any" {
  security_group_id = aws_security_group.changeme_remote_exec_inline_windows_security_group.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule
resource "aws_security_group_rule" "changeme_remote_exec_inline_security_group_rule_incoming_rdp" {
  security_group_id = aws_security_group.changeme_remote_exec_inline_windows_security_group.id
  type              = "ingress"
  from_port         = 3389
  to_port           = 3389
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule
resource "aws_security_group_rule" "changeme_incoming_winrm" {
  security_group_id = aws_security_group.changeme_remote_exec_inline_windows_security_group.id
  type              = "ingress"
  from_port         = 5986
  to_port           = 5986
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance
resource "aws_instance" "changeme_remote_exec_inline_windows_aws_instance" {
  instance_type          = "t2.micro"
  ami                    = "ami-0f93c815788872c5d"
  key_name               = aws_key_pair.changeme_remote_exec_inline_windows_key_pair.id # the name of the SSH keypair to use for provisioning
  vpc_security_group_ids = [aws_security_group.changeme_remote_exec_inline_windows_security_group.id]
  user_data              = file("scripts/user_data.txt")
  get_password_data      = true
  tags                   = { Name = "terraform-examples" }
}

# Documentation: https://www.terraform.io/docs/language/values/outputs.html
output "changeme_admin_password" {
  value = rsadecrypt(aws_instance.changeme_remote_exec_inline_windows_aws_instance.password_data, file(var.changeme_aws_instance_remote_exec_inline_windows_ssh_private_key_path))
}

# Documentation: https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource
resource "null_resource" "changeme_provision_files" {
  # Documentation: https://www.terraform.io/docs/language/resources/provisioners/connection.html
  connection {
    host     = aws_instance.changeme_remote_exec_inline_windows_aws_instance.public_ip
    type     = "winrm"
    user     = "Administrator"
    password = rsadecrypt(aws_instance.changeme_remote_exec_inline_windows_aws_instance.password_data, file(var.changeme_aws_instance_remote_exec_inline_windows_ssh_private_key_path))
    https    = true
    insecure = true
    port     = 5986
    timeout  = "1m"
  }

  # Documentation https://www.terraform.io/docs/language/resources/provisioners/index.html
  provisioner "file" {
    source      = "scripts/hello.ps1"
    destination = "C:/hello.ps1"
  }

  # Documentation: https://www.terraform.io/docs/language/resources/provisioners/remote-exec.html
  provisioner "remote-exec" {
    inline = [
      "powershell.exe -ExecutionPolicy Bypass -File C:/hello.ps1"
    ]
  }
}
