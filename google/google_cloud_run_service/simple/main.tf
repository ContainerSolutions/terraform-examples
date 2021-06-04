# Summary: Creates the simplest GCP Cloud Run Service

# Documentation: https://www.terraform.io/docs/language/settings/index.html
terraform {
  required_version = ">= 0.14.0"
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

# Enable Cloud Run Admin API
# Documentation: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_project_service
resource "google_project_service" "changeme_simple_project_service" {
  project = var.project_id
  service = "run.googleapis.com"

  disable_on_destroy = false
}

# GCP Cloud Run Service
# Documentation: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloud_run_service
resource "google_cloud_run_service" "changeme_simple_cloud_run_service" {
  name     = "changeme-simple-cloud-run-service"
  location = "us-central1"

  template {
    spec {
      containers {
        image = "us-docker.pkg.dev/cloudrun/container/hello"
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}
