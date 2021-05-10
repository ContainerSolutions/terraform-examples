# Summary: Creates the simplest GKE (Google Kubernetes Engine) cluster.

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
  type = string
}

provider "google" {
  project = var.project_id
  region  = "us-central1"
  zone    = "us-central1-a"
}

# GKE
# Documentation: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_cluster
resource "google_container_cluster" "changeme-google-container-cluster-simple" {
  name               = "changeme-google-container-cluster-simple"
  location           = "us-central1-a"
  initial_node_count = 1
  node_config {
    preemptible  = true
    machine_type = "n1-standard-1"
  }
}
