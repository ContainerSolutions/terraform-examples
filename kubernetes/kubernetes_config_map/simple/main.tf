terraform {
  required_version = ">= 0.14.0"
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
  }
}

# ConfigMap

resource "kubernetes_config_map" "config-map-simple" {
  metadata {
    name = "config-map-simple"
  }

  data = {
    api_host = "myhost:443"
    db_host  = "dbhost:5432"
  }
}
