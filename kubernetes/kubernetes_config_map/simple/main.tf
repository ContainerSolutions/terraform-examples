# Summary: Creates a Kubernetes configmap

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

# Documentation: https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/config_map
resource "kubernetes_config_map" "changeme_simple_config_map" {
  metadata {
    name = "changeme-simple-config-map"
  }

  data = {
    api_host = "myhost:443"
    db_host  = "dbhost:5432"
  }
}
