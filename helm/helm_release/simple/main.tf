# Summary: Example helm_release resource

# Documentation: https://www.terraform.io/docs/language/modules/index.html
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    kubernetes = {
      source  = "hashicorp/helm"
      version = "~> 2.0"
    }
  }
}

# Documentation: https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release
resource "helm_release" "changeme_release_simple_ingress_nginx" {
  name = "changeme-release-simple-ingress-nginx-name"

  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  version    = "3.30.0"

  set {
    name  = "controller.service.type"
    value = "ClusterIP"
  }

  set {
    name  = "defaultBackend.enabled"
    value = true
  }
}
