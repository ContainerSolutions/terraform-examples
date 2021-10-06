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
data "archive_file" "changeme_archive_file" {
  type        = "zip"
  source_file = "${path.module}/google/google_cloud_functions/hello_world_app"
  output_path = "${path.root}/hello_world.zip"
}

# Needed to have a unique bucket name globally in GCP
# Documentation: https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id
resource "random_id" "changeme_google_storage_bucket_simple_name" {
  byte_length = 16
}

# Documentation: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket
resource "google_storage_bucket" "changeme_stoarge_bucket" {
  name          = "changeme-${random_id.changeme_google_storage_bucket_simple_name.hex}"
  location      = "US"
}

# Documentation: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_object
resource "google_storage_bucket_object" "changeme_hello_world_zip_object" {
  name   = "changeme_hello_world.zip"
  source = "${path.root}/hello_world.zip"
  bucket = google_storage_bucket.changeme_stoarge_bucket.name
}

# Documentation: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloudfunctions_function
resource "google_cloudfunctions_function" "changeme_function" {
  name        = "changeme_hello_world_function"
  description = "Schedule Hello World Cloud Function"
  runtime     = "python38"
  timeout     = 60
  available_memory_mb   = 128
  source_archive_bucket = google_storage_bucket.changeme_stoarge_bucket.name
  source_archive_object = google_storage_bucket_object.changeme_hello_world_zip_object.name
  trigger_http          = true
  entry_point           = "hello_world"
}