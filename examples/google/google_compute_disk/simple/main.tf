# Summary: Creates a persistent disk

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

# Persistent disks
# Documentation: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_disk
resource "google_compute_disk" "changeme_simple_disk" {
  name = "changeme-simple-disk"
  type = "pd-ssd"
  zone = "us-central1-a"
  size = 4
  labels = {
    environment = "dev"
  }
  physical_block_size_bytes = 4096
}
