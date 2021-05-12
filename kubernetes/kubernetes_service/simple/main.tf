# Summary: A kubernetes service

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

# Documentation:  https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service
resource "kubernetes_service" "changeme_service_simple" {
  metadata {
    name = "changeme-service-simple-name"
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
