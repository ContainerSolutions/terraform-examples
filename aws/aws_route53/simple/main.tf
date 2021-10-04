# Summary: Create a simple route53 zone and TXT record

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
      cs_terraform_examples = "aws_route53/simple"
    }
  }
}


# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_zone
resource "aws_route53_zone" "changeme_aws_route53_simple_zone" {
  name = "changeme.com"
}

# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record
resource "aws_route53_record" "changeme_aws_route53_simple_record" {
  zone_id = aws_route53_zone.changeme_aws_route53_simple_zone.zone_id
  name    = "changeme.com"
  type    = "TXT"
  ttl     = "300"
  records = ["changeme"]
}

