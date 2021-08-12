# Summary: Creates a GKE (Google Kubernetes Engine) cluster, connects the Terraform Kubernetes Provider to it, and creates a k8s deployment.

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
resource "google_container_cluster" "changeme_cluster_and_deployment_cluster" {
  name               = "changeme-cluster-and-deployment-cluster"
  location           = "us-central1-a"
  initial_node_count = 1
  node_config {
    preemptible  = true
    machine_type = "n1-standard-1"
  }
}

# Kubernetes
# Documentation: https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/using_gke_with_terraform

# # Explanation: Retrieve an access token as the Terraform runner
data "google_client_config" "changeme_cluster_and_deployment_provider" {}

# Documentation: https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs
provider "kubernetes" {
  host  = "https://${google_container_cluster.changeme_cluster_and_deployment_cluster.endpoint}"
  token = data.google_client_config.changeme_cluster_and_deployment_provider.access_token
  cluster_ca_certificate = base64decode(
    google_container_cluster.changeme_cluster_and_deployment_cluster.master_auth[0].cluster_ca_certificate,
  )
}

# Deployment
# Documentation: https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/deployment
resource "kubernetes_deployment" "changeme_cluster_and_deployment_deployment" {
  metadata {
    name = "changeme-cluster-and-deployment-deployment"
    labels = {
      app = "changeme-cluster-and-deployment-app"
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "changeme-cluster-and-deployment-app"
      }
    }
    template {
      metadata {
        labels = {
          app = "changeme-cluster-and-deployment-app"
        }
      }
      spec {
        container {
          image = "nginx"
          name  = "nginx"
        }
      }
    }
  }
}
