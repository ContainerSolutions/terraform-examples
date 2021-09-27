# Summary: A simple Cloud Function example with a dummy Python function

# Documentation: https://www.terraform.io/docs/language/settings/index.html
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 3.0"
    }
  }
}

# Documentation: https://www.terraform.io/docs/language/values/variables.html
variable "project_id" {
  type = string
}

# Documentation: https://www.terraform.io/docs/language/providers/requirements.html
provider "google" {
  project = var.project_id
  region  = "us-central1"
  zone    = "us-central1-a"
}

# Documentation: https://registry.terraform.io/providers/hashicorp/archive/latest/docs/data-sources/archive_file
data "archive_file" "init" {
  type        = "zip"
  source_file = "${path.module}/init.tpl"
  output_path = "${path.module}/files/init.zip"
}

# Documentation: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket

// tbd: create the storage bucket

// tbd place the zip-ed code in the bucket

# Documentation: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloudfunctions_function

// tbd: create the Cloud Function here
