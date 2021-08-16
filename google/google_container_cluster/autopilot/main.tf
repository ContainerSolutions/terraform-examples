# Summary: Creates a GKE (Google Kubernetes Engine) Autopilot cluster.

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

# GKE
# Documentation: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_cluster
resource "google_container_cluster" "changeme_autopilot_cluster" {
  name     = "changeme-autopilot-cluster"
  location = "us-central1"

  # Documentation: https://cloud.google.com/kubernetes-engine/docs/concepts/autopilot-overview
  enable_autopilot = true
}
