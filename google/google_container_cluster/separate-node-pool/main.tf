# Summary: Creates a GKE (Google Kubernetes Engine) cluster with a separatelly managed node pool.

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
resource "google_container_cluster" "changeme-cluster-separate-node-pool" {
  name     = "changeme-cluster-separate-node-pool"
  location = "us-central1-a"

  # Explanation: Cannot create a cluster with no node pool. So we create a pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1
}

# Node Pool in a GKE cluster (managed separately)
# Documentation: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_node_pool
resource "google_container_node_pool" "changeme-node-pool-separate-node-pool" {
  name       = "changeme-node-pool-separate-node-pool"
  location   = "us-central1-a"
  cluster    = google_container_cluster.changeme-cluster-separate-node-pool.name
  node_count = 1

  node_config {
    preemptible  = true
    machine_type = "n1-standard-1"
  }
}
