# Summary: Create a simple AWS RDS DB Instance with MySQL 

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
      cs_terraform_examples = "aws_db_instance/simple"
    }
  }
}

# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance
# Explanation: This resource creates the DB Instance. This Example creates a MySql Server version 5.7 as a Managed RDS Service.
# Allocates a MySQl version 5.7 in a t3.micro instance with a database name 'changeme_simple_aws_db_instance', username 'changeme_username' and passwd 'changeme_password'
resource "aws_db_instance" "changeme_simple_aws_db_instance" {
  allocated_storage   = 5
  engine              = "mysql"
  engine_version      = "5.7"
  instance_class      = "db.t3.micro"
  name                = "changeme_simple_aws_db_instance"
  username            = "changemeusername"
  password            = "changeme_password"
  skip_final_snapshot = true
}

##Explanation:
# Details on Arguments:
# Required Argument -  allocated_storage: How Much storage will be allocated for the Database in Gbi
# Required Argument -             engine: Engines Types like MySql, Postgres, MariaDB....
# Required Argument -     engine_version: The above choosen version of Engine. For ex:  MySQL version 5.7
# Required Argument -     instance_class: The size of the Instance (VM)
# Required Argument -           username: The Master DB-User username
# Required Argument -            passord: The master DB-User password
# Optional Argument -               name: The Name of the Instance
# Optional Argument -  skip_final_snapshot: It's needed for destroying the instance with Terraform Destroy
