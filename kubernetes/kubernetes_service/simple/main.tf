terraform {
  required_version = ">= 0.14.0"
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
  }
}

# Service

resource "kubernetes_service" "service-simple" {
  metadata {
    name = "service-simple"
  }
  spec {
    selector = {
      app = "deployment-simple-app"
    }
    port {
      port        = 80
      target_port = 80
    }
  }
}
