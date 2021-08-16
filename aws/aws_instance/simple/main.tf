# Summary: Simplest example of an aws_instance resource
#
# Note: This example simply creates the VM, but does not set up a keypair,
#       or networking such that you can ssh into it from the internet.
#       For a more complete example, see `aws/aws_instance/remote_exec/inline`.

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
      cs_terraform_examples = "aws_instance/simple"
    }
  }
}

# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance
resource "aws_instance" "changeme_aws_resource_simple" {
  instance_type = "t2.nano"
  ami           = "ami-0ddbdea833a8d2f0d"
}
