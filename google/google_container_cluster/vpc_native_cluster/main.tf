# Summary: Creates a VPC-native GKE (Google Kubernetes Engine) cluster .
# Documentation: https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/using_gke_with_terraform#vpc-native-clusters

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

# Google VPC network
# Documentation: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_network
resource "google_compute_network" "changeme_vpc_native_cluster_vpc" {
  name                    = "changeme-vpc-native-cluster-vpc"
  auto_create_subnetworks = false
}

# Subnetwork
# Documentation: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork
resource "google_compute_subnetwork" "changeme_vpc_native_cluster_subnet" {
  name          = "changeme-vpc-native-cluster-subnet"
  ip_cidr_range = "10.2.0.0/16"
  region        = "us-central1"
  network       = google_compute_network.changeme_vpc_native_cluster_vpc.id
  secondary_ip_range {
    range_name    = "services-range"
    ip_cidr_range = "192.168.1.0/24"
  }

  secondary_ip_range {
    range_name    = "pod-ranges"
    ip_cidr_range = "192.168.64.0/22"
  }
}

# GKE
# Documentation: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_cluster
resource "google_container_cluster" "changeme_vpc_native_cluster" {
  name               = "changeme-vpc-native-cluster"
  location           = "us-central1-a"
  initial_node_count = 1

  network    = google_compute_network.changeme_vpc_native_cluster_vpc.id
  subnetwork = google_compute_subnetwork.changeme_vpc_native_cluster_subnet.id

  ip_allocation_policy {
    cluster_secondary_range_name  = "services-range"
    services_secondary_range_name = google_compute_subnetwork.changeme_vpc_native_cluster_subnet.secondary_ip_range.1.range_name
  }

  node_config {
    preemptible  = true
    machine_type = "n1-standard-1"
  }
}
