terraform {
  required_version = ">= 0.14.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 3.0"
    }
  }
}

variable "project_id" {
  description = "project id"
  type        = string
}

provider "google" {
  project = var.project_id
  region  = "us-central1"
  zone    = "us-central1-c"
}

# VPC
resource "google_compute_network" "vpc-simple" {
  name                    = "vpc-simple"
  auto_create_subnetworks = "false"
}

# Subnet
resource "google_compute_subnetwork" "vpc-simple-subnet-1" {
  name          = "${google_compute_network.vpc-simple.name}-subnet-1"
  region        = "us-central1"
  network       = google_compute_network.vpc-simple.name
  ip_cidr_range = "10.10.0.0/24"
}
