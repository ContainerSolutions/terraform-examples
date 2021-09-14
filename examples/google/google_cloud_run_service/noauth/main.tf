# Summary: Creates a GCP Cloud Run Service accessible without auth

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

# GCP Cloud Run Service
# Documentation: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloud_run_service
resource "google_cloud_run_service" "changeme_noauth_cloud_run_service" {
  name     = "changeme-noauth-cloud-run-service"
  location = "us-central1"

  template {
    spec {
      containers {
        image = "us-docker.pkg.dev/cloudrun/container/hello"
      }
    }
  }
}

# Documentation: https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/iam_policy
data "google_iam_policy" "changeme_noauth_iam_policy" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }
}

# Documentation: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloud_run_service_iam
resource "google_cloud_run_service_iam_policy" "changeme_noauth" {
  location = google_cloud_run_service.changeme_noauth_cloud_run_service.location
  project  = google_cloud_run_service.changeme_noauth_cloud_run_service.project
  service  = google_cloud_run_service.changeme_noauth_cloud_run_service.name

  policy_data = data.google_iam_policy.changeme_noauth_iam_policy.policy_data
}
