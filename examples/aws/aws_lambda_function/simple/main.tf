# Summary: Create a lambda function in AWS

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
      cs_terraform_examples = "aws_lambda_function/simple"
    }
  }
}

# Documentation: https://www.terraform.io/docs/language/values/variables.html
variable "changeme_lambda_function_name" {
  description = "the name of your stack, e.g. \"demo\""
  default     = "lambda-example"
}

# Documentation: https://www.terraform.io/docs/language/values/variables.html
variable "changeme_lambda_function_runtime" {
  description = "the runtime environment of your function"
  default     = "nodejs12.x"
}

# Documentation: https://www.terraform.io/docs/language/values/variables.html
variable "changeme_lambda_function_zip" {
  description = "the zip file containing your code for your lambda function"
  default     = "lambda_function_payload.zip"
}

# Documentation: https://www.terraform.io/docs/language/values/variables.html
variable "changeme_lambda_function_handler" {
  description = "the name of the handler function"
  default     = "main.handler"
}

# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role
resource "aws_iam_role" "changeme_lambda_function_iam_role" {
  name = "${var.changeme_lambda_function_name}-lambda-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_lambda_function" "changeme_lambda_function" {
  filename      = var.changeme_lambda_function_zip
  function_name = var.changeme_lambda_function_name
  role          = aws_iam_role.changeme_lambda_function_iam_role.arn
  handler       = var.changeme_lambda_function_handler

  # The filebase64sha256() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the base64sha256() function and the file() function:
  # source_code_hash = "${base64sha256(file("lambda_function_payload.zip"))}"
  source_code_hash = filebase64sha256("${var.changeme_lambda_function_zip}")

  runtime = var.changeme_lambda_function_runtime
}
