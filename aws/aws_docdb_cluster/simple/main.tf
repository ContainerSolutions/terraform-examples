# Summary: Create a DocumentDB Cluster with 3 instances

# Documentation: https://www.terraform.io/docs/language/settings/index.html
terraform {
  #required_version = ">= 1.0.0"
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
      cs_terraform_examples = "aws_docdb_cluster/simple"
    }
  }
}

# Documentation: https://www.terraform.io/docs/language/values/variables.html
variable "changeme_aws_docdb_cluster_username" {
  type        = string
  description = "the username for the login credentials to your db"
  default     = "username_example"
}

# Documentation: https://www.terraform.io/docs/language/values/variables.html
variable "changeme_aws_docdb_cluster_password" {
  type        = string
  description = "the password"
  default     = "password_example"
}

# Documentation: https://www.terraform.io/docs/language/values/variables.html
variable "changeme_aws_docdb_cluster_instances_count" {
  type        = number
  description = "the amount of instances for the cluster"
  default     = 3
}

# Documentation: https://www.terraform.io/docs/language/values/variables.html
variable "changeme_aws_docdb_cluster_instances_type" {
  type        = string
  description = "type of instance to use"
  default     = "db.r5.large"
}

# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/docdb_cluster
resource "aws_docdb_cluster" "changeme_aws_docdb_cluster_instance" {
  # The login credentials are stored as plain-text in the state files
  # https://www.terraform.io/docs/language/state/sensitive-data.html
  # For security, use a secrets manager
  # https://registry.terraform.io/modules/yurymkomarov/rds-aurora-cluster/aws/latest#secretsmanager_secret
  cluster_identifier  = "changeme-aws-docdb-cluster"
  master_username     = var.changeme_aws_docdb_cluster_username
  master_password     = var.changeme_aws_docdb_cluster_password
  skip_final_snapshot = true
}

# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/docdb_cluster_instance
resource "aws_docdb_cluster_instance" "changeme_aws_docdb_cluster_instances" {
  count              = var.changeme_aws_docdb_cluster_instances_count
  identifier         = "changeme-aws-docdb-cluster-instance-${count.index}"
  cluster_identifier = aws_docdb_cluster.changeme_aws_docdb_cluster_instance.id
  instance_class     = var.changeme_aws_docdb_cluster_instances_type
}