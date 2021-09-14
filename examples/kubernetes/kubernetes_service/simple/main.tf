# Summary: A kubernetes service

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

# Documentation:  https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service
resource "kubernetes_service" "changeme_simple_service" {
  metadata {
    name = "changeme-simple-service"
  }
  spec {
    selector = {
      app = "changeme-simple-deployment"
    }
    port {
      port        = 80
      target_port = 80
    }
  }
}
