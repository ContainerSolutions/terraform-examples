# Summary: Create a table with one item in AWS DynamoDB

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
      cs_terraform_examples = "aws_dynamodb_table_item/simple"
    }
  }
}

# Documentation: https://www.terraform.io/docs/language/values/variables.html
variable "changeme_item_hash_key" {
  description = "the hash key that's also defined as an attribute"
  default     = "example_hash_key"
}

# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table_item
resource "aws_dynamodb_table_item" "changeme_dynamodb_table_item" {
  table_name = aws_dynamodb_table.changeme_aws_dynamodb_table_resource.name
  hash_key   = aws_dynamodb_table.changeme_aws_dynamodb_table_resource.hash_key

  item = <<ITEM
{
  "example_hash_key": {"S": "something"},
  "example_attribute": {"N": "11111"}
}
ITEM
}

# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table
resource "aws_dynamodb_table" "changeme_aws_dynamodb_table_resource" {
  name           = "changeme_dynamodb_table_name" # Explanation: the table's name, which needs to be unique to a region
  read_capacity  = 10                             # Explanation: the number of read units for the table
  write_capacity = 10                             # Explanation: the number of write units for the table
  hash_key       = var.changeme_item_hash_key

  attribute {
    name = var.changeme_item_hash_key # Explanation: the attribute must be of type [S]tring, [N]umber, or [B]inary
    type = "S"
  }
}
