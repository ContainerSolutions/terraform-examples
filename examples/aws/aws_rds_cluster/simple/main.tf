# Summary: Create an RDS Aurora MySQL 1 Cluster instance that does not inherit configuration from the cluster

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
  region  = "us-east-1"
  profile = "terraform-examples"
  default_tags {
    tags = {
      cs_terraform_examples = "aws_rds_cluster/simple"
    }
  }
}

# Documentation: https://www.terraform.io/docs/language/values/variables.html
variable "changeme_aws_aurora_username" {
  description = "the username for the login credentials to your db"
  default     = "username_example"
}

# Documentation: https://www.terraform.io/docs/language/values/variables.html
variable "changeme_aws_aurora_password" {
  description = "the password, which must be more than 8 characters long"
  default     = "password_example"
}

# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster
resource "aws_rds_cluster" "changeme_aws_aurora_cluster" {
  # The login credentials are stored as plain-text in the state files
  # https://www.terraform.io/docs/language/state/sensitive-data.html
  # For security, use a secrets manager
  # https://registry.terraform.io/modules/yurymkomarov/rds-aurora-cluster/aws/latest#secretsmanager_secret
  master_username     = var.changeme_aws_aurora_username
  master_password     = var.changeme_aws_aurora_password
  skip_final_snapshot = true
}
