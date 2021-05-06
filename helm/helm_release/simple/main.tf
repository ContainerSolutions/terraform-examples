terraform {
  required_version = ">= 0.14.0"
  required_providers {
    kubernetes = {
      source = "hashicorp/helm"
      version = "~> 2.0"
    }
  }
}

# Helm Release

resource "helm_release" "release-simple-ingress-nginx" {
  name       = "release-simple-ingress-nginx"

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
