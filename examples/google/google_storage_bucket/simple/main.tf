# Summary: Creates a GCS (Google Cloud Storage) bucket

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

# Explanation: This resource is not necessary for the creation of an GCS bucket, but is here to ensure that
# the GCS bucket name is unique.
#
# Documentation: https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id
resource "random_id" "changeme_google_storage_bucket_simple_name" {
  byte_length = 16
}

# GCS (Google Cloud Storage) bucket
# Documentation: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket
resource "google_storage_bucket" "changeme_google_storage_simple_bucket" {
  name     = "changeme-${random_id.changeme_google_storage_bucket_simple_name.hex}"
  location = "US"
}
