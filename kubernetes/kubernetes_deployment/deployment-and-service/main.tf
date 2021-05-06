terraform {
  required_version = ">= 0.14.0"
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
  }
}

# Namespace

resource "kubernetes_namespace" "deployment-and-service" {
  metadata {
    name = "deployment-and-service"
  }
}

# Deployment

resource "kubernetes_deployment" "deployment-and-service" {
  metadata {
    name      = "deployment-and-service"
    namespace = kubernetes_namespace.deployment-and-service.metadata.0.name
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

# Service

resource "kubernetes_service" "deployment-and-service" {
  metadata {
    name      = "deployment-and-service"
    namespace = kubernetes_namespace.deployment-and-service.metadata.0.name
  }
  spec {
    selector = {
      app = kubernetes_deployment.deployment-and-service.spec.0.template.0.metadata[0].labels.app
    }
    port {
      port        = 80
      target_port = 80
    }
  }
}
