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
  type    = string
  default = "changeme_myprojectid"
}

# Documentation: https://www.terraform.io/docs/language/providers/requirements.html
provider "google" {
  project = var.project_id
  region  = "us-central1"
  zone    = "us-central1-a"
}

# Documentation: https://registry.terraform.io/providers/hashicorp/archive/latest/docs/data-sources/archive_file
# Documentation (path.module): https://www.terraform.io/docs/language/expressions/references.html#filesystem-and-workspace-info
data "archive_file" "changeme_archive_file" {
  type        = "zip"
  source_dir  = "${path.module}/hello_world_app"
  output_path = "${path.module}/hello_world.zip"
}

# Needed to have a unique bucket name globally in GCP
# Documentation: https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id
resource "random_id" "changeme_google_storage_bucket_simple_name_2" {
  byte_length = 16
}

# Documentation: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket
resource "google_storage_bucket" "changeme_stoarge_bucket" {
  name     = "changeme-${random_id.changeme_google_storage_bucket_simple_name_2.hex}"
  location = "US"
}

# Documentation: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_object
resource "google_storage_bucket_object" "changeme_hello_world_zip_object" {
  name   = "hello_world.zip"
  source = "${path.module}/hello_world.zip"
  bucket = google_storage_bucket.changeme_stoarge_bucket.name
}

# Documentation: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloudfunctions_function
resource "google_cloudfunctions_function" "changeme_function" {
  name                  = "changeme_hello_world_function"
  description           = "Schedule Hello World Cloud Function"
  runtime               = "python38"
  timeout               = 60
  available_memory_mb   = 128
  source_archive_bucket = google_storage_bucket.changeme_stoarge_bucket.name
  source_archive_object = google_storage_bucket_object.changeme_hello_world_zip_object.name
  trigger_http          = true
  entry_point           = "hello_world"
}

# Needed for the function to be invoked without authentication
# by anyone on the internet, since it's a public http (hello world) function
# Documentation: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloudfunctions_function_iam
resource "google_cloudfunctions_function_iam_member" "changeme_invoker" {
  project        = google_cloudfunctions_function.changeme_function.project
  region         = google_cloudfunctions_function.changeme_function.region
  cloud_function = google_cloudfunctions_function.changeme_function.name

  role   = "roles/cloudfunctions.invoker"
  member = "allUsers"
}