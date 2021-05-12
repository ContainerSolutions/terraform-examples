# Summary: A Kubernetes deployment

# Documentation: https://www.terraform.io/docs/language/settings/index.html
terraform {
  required_version = ">= 0.14.0"
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
  }
}

# Documentation: https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/deployment
resource "kubernetes_deployment" "changeme_deployment_simple" {
  metadata {
    name = "deployment-simple"
    labels = {
      app = "deployment-simple-app"
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "deployment-simple-app"
      }
    }
    template {
      metadata {
        labels = {
          app = "deployment-simple-app"
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
