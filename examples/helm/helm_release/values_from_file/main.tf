# Summary: Example helm_release, getting values from a file

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
resource "helm_release" "changeme_release_values_from_file_ingress_nginx" {
  name = "changeme-release-values-from-file-ingress-nginx-name"

  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  version    = "3.30.0"

  values = [
    "${file("values.yaml")}"
  ]
}
