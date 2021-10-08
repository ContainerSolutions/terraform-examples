# Summary: Creates a simple route53 alias record and a static S3 site

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
      cs_terraform_examples = "aws_route53/alias"
    }
  }
}

# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document
data "aws_iam_policy_document" "changeme_iam_policy_document" {
  statement {
    sid = "BucketForStaticWebsite"

    actions = [
      "s3:GetObject",
    ]

    resources = [
      "arn:aws:s3:::*",
    ]

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
  }
}

# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket
resource "aws_s3_bucket" "changeme_s3_bucket" {
  bucket_prefix = "changeme"
  acl           = "public-read"
  policy        = data.aws_iam_policy_document.changeme_iam_policy_document.json

  website {
    index_document = "index.html"
    error_document = "error.html"
  }
}

# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_object
resource "aws_s3_bucket_object" "changeme_example_index_object" {
  key    = "index.html"
  bucket = aws_s3_bucket.changeme_s3_bucket.id
  source = "${path.module}/alias_record/static_website/index.html"
}

resource "aws_s3_bucket_object" "changeme_example_error_object" {
  key    = "error.html"
  bucket = aws_s3_bucket.changeme_s3_bucket.id
  source = "${path.module}/alias_record/static_website/error.html"
}

# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_zone
resource "aws_route53_zone" "changeme_aws_route53_alias" {
  name = "changemealias.com"
}

# Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record
resource "aws_route53_record" "changeme_aws_route53_alias_record" {
  zone_id = aws_route53_zone.changeme_aws_route53_alias.zone_id
  name    = "changemealias.com"
  type    = "A"
  alias {
    name                   = aws_s3_bucket.changeme_s3_bucket.id
    zone_id                = aws_s3_bucket.changeme_s3_bucket.hosted_zone_id
    evaluate_target_health = true
  }
}
