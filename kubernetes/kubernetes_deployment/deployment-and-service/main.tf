# Summary: Create a Kubernetes deployment and service

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

# Documentation: https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace
resource "kubernetes_namespace" "changeme_deployment_and_service_namespace" {
  metadata {
    name = "deployment-and-service"
  }
}

# Documentation: https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/deployment
resource "kubernetes_deployment" "changeme_deployment_and_service_deployment" {
  metadata {
    name      = "deployment-and-service"
    namespace = kubernetes_namespace.changeme_deployment_and_service_namespace.metadata.0.name
    labels = {
      app = "deployment-and-service-app"
    }
  }

  spec {
    replicas = 2
    selector {
      match_labels = {
        app = "deployment-and-service-app"
      }
    }
    template {
      metadata {
        labels = {
          app = "deployment-and-service-app"
        }
      }
      spec {
        container {
          image = "nginx"
          name  = "nginx"

          port {
            container_port = 80
          }

        }
      }
    }
  }
}

# Documentation: https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service
resource "kubernetes_service" "changeme_deployment_and_service_service" {
  metadata {
    name      = "deployment-and-service"
    namespace = kubernetes_namespace.changeme_deployment_and_service_namespace.metadata.0.name
  }
  spec {
    selector = {
      app = kubernetes_deployment.changeme_deployment_and_service_deployment.spec.0.template.0.metadata[0].labels.app
    }
    port {
      port        = 80
      target_port = 80
    }
  }
}
