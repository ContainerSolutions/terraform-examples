# Summary: Uses the 'count' feature to create multiple EC2 instances.

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
  type        = string
}

# Documentation: https://www.terraform.io/docs/language/providers/requirements.html
provider "google" {
  project = var.project_id
  region  = "us-central1"
  zone    = "us-central1-c"
}

# Documentation: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_network
resource "google_compute_network" "changeme_vpc_simple" {
  name                    = "changeme-vpc-simple-name"
  auto_create_subnetworks = "false"
}

# Documentation: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork
resource "google_compute_subnetwork" "changeme_vpc_simple_subnet_1" {
  name          = "changeme-${google_compute_network.changeme_vpc_simple.name}-subnet-1"
  region        = "us-central1"
  network       = google_compute_network.changeme_vpc_simple.name
  ip_cidr_range = "10.10.0.0/24"
}
