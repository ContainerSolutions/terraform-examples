# Summary: Creates a NOSQL database instance on the gcp console

# Documentation: https://www.terraform.io/docs/language/settings/index.html
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
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

# CloudBigtable NOSQL database instance
# Documentation: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/bigtable_instance
resource "google_bigtable_instance" "changeme_cloudbigtable_database" {
  name = "changeme-cloudbigtable-db"

  deletion_protection = false

  cluster {
    cluster_id = "changeme-cluster-id"
    num_nodes  = 1
  }
}
