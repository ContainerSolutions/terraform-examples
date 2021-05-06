terraform {
  required_version = ">= 0.14.0"
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
  }
}

# Deployment

resource "kubernetes_deployment" "deployment-simple" {
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
