terraform {
  required_version = ">= 0.14.0"
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
  }
}

# NameSpace

resource "kubernetes_namespace" "namespace-simple" {
  metadata {
    name = "namespace-simple"
  }
}
