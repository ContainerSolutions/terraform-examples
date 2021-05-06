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

resource "kubernetes_config_map" "config-map-from-files" {
  metadata {
    name = "config-map-from-files"
  }

  data = {
    "my_config_file.yml" = "${file("${path.module}/my_config_file.yml")}"
  }

  binary_data = {
    "my_payload.bin" = "${filebase64("${path.module}/my_payload.bin")}"
  }
}
