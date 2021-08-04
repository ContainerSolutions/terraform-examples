# Summary: Creates a GKE (Google Kubernetes Engine) cluster with a separatelly managed node pool.

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
resource "google_container_cluster" "changeme_separate_node_pool_cluster" {
  name     = "changeme-separate-node-pool-cluster"
  location = "us-central1-a"

  # Explanation: Cannot create a cluster with no node pool. So we create a pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1
}

# Node Pool in a GKE cluster (managed separately)
# Documentation: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_node_pool
resource "google_container_node_pool" "changeme_separate_node_pool" {
  name       = "changeme-separate-node-pool"
  location   = "us-central1-a"
  cluster    = google_container_cluster.changeme_separate_node_pool_cluster.name
  node_count = 1

  node_config {
    preemptible  = true
    machine_type = "n1-standard-1"
  }
}
