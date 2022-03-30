# Summary: Creates a simple Classic Elastic Load Balancer with two EC2 Instances 
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
  region = "us-east-2"
  default_tags {
    tags = {
      cs_terraform_examples = "aws_elb/classic_elb"
    }
  }
}

# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group
# See also: [aws/aws_security_group/ssh](https://github.com/ContainerSolutions/terraform-examples/tree/main/aws/aws_security_group/ssh)
resource "aws_security_group" "changeme_aws_security_group" {
  name        = "changeme-aws-security-group-classic-elb-name"
  description = "Allow HTTP 8080 inbound traffic"
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance
# Explanation: Deploys the first Server in us-east-2a
resource "aws_instance" "changeme_first_aws_instance" {
  ami                    = "ami-0c55b159cbfafe1f0"
  instance_type          = "t2.micro"
  availability_zone      = "us-east-2a"
  vpc_security_group_ids = [aws_security_group.changeme_aws_security_group.id]
  user_data              = <<-EOF
              #!/bin/bash
              echo "Hello, World from Host1" > index.html
              nohup busybox httpd -f -p 8080 &
              EOF
  tags = {
    Name = "changeme_first_aws_instance_tag"
  }
}

# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance
# Explanation: Deploys the second Server in us-east-2b 
resource "aws_instance" "changeme_second_aws_instance" {
  ami                    = "ami-0c55b159cbfafe1f0"
  instance_type          = "t2.micro"
  availability_zone      = "us-east-2b"
  vpc_security_group_ids = [aws_security_group.changeme_aws_security_group.id]
  user_data              = <<-EOF
              #!/bin/bash
              echo "Hello, World from Host2" > index.html
              nohup busybox httpd -f -p 8080 &
              EOF
  tags = {
    Name = "changeme_second_aws_instance_tag"
  }
}

# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elb
# Explanation: Deploys the Classic Load Balancer, allows traffic in 8080 ports 
resource "aws_elb" "changeme_simple_aws_elb" {
  name               = "changeme-simple-aws-elb"
  availability_zones = ["us-east-2a", "us-east-2b"]



  listener {
    instance_port     = 8080
    instance_protocol = "http"
    lb_port           = 8080
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 10
    unhealthy_threshold = 2
    timeout             = 5
    target              = "HTTP:8080/"
    interval            = 10
  }

  instances                   = [aws_instance.changeme_first_aws_instance.id, aws_instance.changeme_second_aws_instance.id]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags = {
    Name = "changeme_simple_aws_elb_tag"
  }
}
