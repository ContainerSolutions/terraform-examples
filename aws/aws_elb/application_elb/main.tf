# Summary: Creates a simple Application Load Balancer and an ASG

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
      cs_terraform_examples = "aws_elb/application_elb"
    }
  }
}

# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc
data "aws_vpc" "changeme_default_aws_vpc_alb" {
  default = true
}

# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet_ids
data "aws_subnet_ids" "changeme_aws_subnet_ids_alb" {
  vpc_id = data.aws_vpc.changeme_default_aws_vpc_alb.id
}

# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group
resource "aws_security_group" "changeme_alb_aws_security_group" {
  name        = "changeme-simple-alb-security-group"
  description = "Allow HTTP 80 inbound traffic"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group
resource "aws_lb_target_group" "changeme_simple_alb_target_group" {
  name     = "changeme-simple-alb-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.changeme_default_aws_vpc_alb.id

  health_check {
    healthy_threshold   = 3
    unhealthy_threshold = 2
    interval            = 5
    timeout             = 2
    matcher             = "200"
  }
}

# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb
resource "aws_lb" "changeme_simple_aws_alb" {
  name               = "changeme-simple-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = data.aws_subnet_ids.changeme_aws_subnet_ids_alb.ids
  security_groups    = [aws_security_group.changeme_alb_aws_security_group.id]
}

# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener
resource "aws_lb_listener" "changeme_simple_alb_listener" {
  load_balancer_arn = aws_lb.changeme_simple_aws_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.changeme_simple_alb_target_group.arn
  }
}

# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami
data "aws_ami" "changeme_amazon_alb_ami" {
  owners      = ["amazon"]
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template
resource "aws_launch_template" "changeme_simple_asg_launch_template_alb" {
  name                   = "changeme-simple-asg-launch-template-alb"
  image_id               = data.aws_ami.changeme_amazon_alb_ami.id #"ami-087c17d1fe0178315"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.changeme_alb_aws_security_group.id]
  user_data              = filebase64("${path.module}/user_data.sh")
}

# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group
resource "aws_autoscaling_group" "changeme_simple_autoscaling_group_alb" {
  name               = "changeme-simple-autoscaling-group-alb"
  availability_zones = ["us-east-1a", "us-east-1b"]
  desired_capacity   = 2
  max_size           = 2
  min_size           = 2
  target_group_arns  = [aws_lb_target_group.changeme_simple_alb_target_group.arn]

  launch_template {
    id = aws_launch_template.changeme_simple_asg_launch_template_alb.id
  }
}
