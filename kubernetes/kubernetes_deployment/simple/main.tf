# Summary: A Kubernetes deployment

# Documentation: https://www.terraform.io/docs/language/settings/index.html
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
  }
}

# Documentation: https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/deployment
resource "kubernetes_deployment" "changeme_simple_deployment" {
  metadata {
    name = "changeme-simple-deployment"
    labels = {
      app = "changeme-simple-deployment"
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "changeme-simple-deployment"
      }
    }
    template {
      metadata {
        labels = {
          app = "changeme-simple-deployment"
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
