# Summary: Create a DB Instance PROD. Takes a snapshot (latest), and with the latest snapshot,creates a new DEV Instance. 

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
      cs_terraform_examples = "aws_db_instance/mount_db_snapshot"
    }
  }
}

# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance
# See also: (aws/aws_db_instance/simple)
# Explanation: This resource creates the DB Instance. This Example creates a MySQL  version 5.7 as a Managed RDS Service.
resource "aws_db_instance" "changeme_aws_db_instance_prod" {
  allocated_storage         = 10
  engine                    = "mysql"
  engine_version            = "5.7"
  instance_class            = "db.t2.micro"
  name                      = "changeme_db_prod"
  identifier                = "changeme-db-identifier"
  username                  = "changeme_username_prod"
  password                  = "changeme_password_prod"
  final_snapshot_identifier = "changeme-final-snapshot"
  skip_final_snapshot       = true # change to false if you want to keep snapshot after deleting the instance
}


# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_snapshot
# Explanation: Run a backup snapshot from prod Database. It uses timeouts for waiting until the snapshot operation complete
resource "aws_db_snapshot" "changeme_db_prod_snapshot" {
  db_instance_identifier = aws_db_instance.changeme_aws_db_instance_prod.id
  db_snapshot_identifier = "changeme-prod-snapshot"
  timeouts {
    read = "10m"
  }

  depends_on = [
    aws_db_instance.changeme_aws_db_instance_prod
  ]

}

# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/db_snapshot
# Explanation: Data Source, reads the latest snapshot from the prod Database and gets its id
data "aws_db_snapshot" "changeme_latest_prod_snapshot" {
  depends_on = [
    aws_db_snapshot.changeme_db_prod_snapshot
  ]
  db_instance_identifier = aws_db_instance.changeme_aws_db_instance_prod.id
  most_recent            = true

}

# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance
# Explanation: Use the latest production snapshot to create a DEV instance DB.
resource "aws_db_instance" "changeme_db_dev" {
  instance_class      = "db.t2.micro"
  identifier          = "changeme-db-from-backup"
  snapshot_identifier = data.aws_db_snapshot.changeme_latest_prod_snapshot.id
  skip_final_snapshot = true

  lifecycle {
    ignore_changes = [snapshot_identifier]
  }
}
