# Summary: Attaches a persistent disk to an instance with google_compute_attached_disk resource type

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

# Attach a disk to an instance
# Documentation: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_attached_disk
resource "google_compute_attached_disk" "changeme_simple_attached_disk" {
  disk     = google_compute_disk.changeme_simple_attached_disk_disk.id
  instance = google_compute_instance.changeme_simple_attached_disk_instance.id
}

# Compute Instance
# Documentation: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance
resource "google_compute_instance" "changeme_simple_attached_disk_instance" {
  name         = "changeme-simple-attached-disk-instance"
  machine_type = "f1-micro"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  network_interface {
    # Explanation: A default network is created for all GCP projects
    network = "default"
    access_config {
    }
  }
}

# Persistent disks
# Documentation: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_disk
resource "google_compute_disk" "changeme_simple_attached_disk_disk" {
  name = "changeme-simple-attached-disk-disk"
  type = "pd-ssd"
  zone = "us-central1-a"
  size = 4
  labels = {
    environment = "dev"
  }
  physical_block_size_bytes = 4096
}
