# Summary: Creates a Kubernetes configmap

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

# Documentation: https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/config_map
resource "kubernetes_config_map" "changeme_config_map_simple" {
  metadata {
    name = "changeme-config-map-simple-name"
  }

  data = {
    api_host = "myhost:443"
    db_host  = "dbhost:5432"
  }
}
