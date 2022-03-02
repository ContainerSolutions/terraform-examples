# Summary: Create a DB Instance and take a snapshot

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
      cs_terraform_examples = "aws_db_instance/db_snapshot"
    }
  }
}

# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance
# See also: (aws/aws_db_instance/simple)
# Explanation: This resource creates the DB Instance. This Example creates a MySQL  version 5.6.17 as a Managed RDS Service.
resource "aws_db_instance" "changeme_aws_db_intance_myqsl" {
  allocated_storage       = 15
  engine                  = "mysql"
  engine_version          = "5.7"
  instance_class          = "db.t3.micro"
  name                    = "changeme_simple_aws_db_instance"
  username                = "changemeusername"
  password                = "changeme_password"
  maintenance_window      = "Sat:07:00-Sat:07:30"
  backup_retention_period = 0
  skip_final_snapshot     = true
}

# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_snapshot
resource "aws_db_snapshot" "changeme_aws_db_snapshot" {
  db_instance_identifier = aws_db_instance.changeme_aws_db_intance_myqsl.id
  db_snapshot_identifier = "changeme-snapshot-cs-2021"


}
