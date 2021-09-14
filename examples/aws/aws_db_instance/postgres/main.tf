# Summary: Create a simple AWS RDS DB Instance with Postgresql 

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
      cs_terraform_examples = "aws_db_instance/postgres"
    }
  }
}

# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance
# Explanation: This resource creates the DB Instance. This Example creates a Postgresql Server version 9.6.9 as a Managed RDS Service.
# Allocates a Postgres Database service version 9.6.9 in a t3.micro instance with a database name 'changeme_simple_postgresql_instance', username 'changeme_username' and passwd 'changeme_password'
resource "aws_db_instance" "changeme_simple_postgresql_instance" {
  allocated_storage   = 5
  engine              = "postgres"
  engine_version      = "12.5"
  instance_class      = "db.t3.micro"
  name                = "changeme_simple_postgresql_instance"
  username            = "changeme_username"
  password            = "changeme_password"
  skip_final_snapshot = true
  storage_encrypted   = false
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
# Optional Argument -  storage_encrypted: If data is going to be encrypted at rest or not
