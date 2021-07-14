# Summary: A simple Azure Kubernetes Cluster
# Explanation: Also known as Azure Kubernetes Service (AKS)

# Documentation: https://www.terraform.io/docs/language/settings/index.html
terraform {
  required_version = ">= 0.14.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.0"
    }
  }
}

# Documentation: https://www.terraform.io/docs/language/values/variables.html
variable "azure_subscription_id" {
  type = string
}

# Documentation: https://www.terraform.io/docs/language/providers/requirements.html
# Documentation: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs
provider "azurerm" {
  features {}

  subscription_id = var.azure_subscription_id
}

# Resource Group
# Documentation: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group
resource "azurerm_resource_group" "changeme_simple_kubernetes_cluster_resource_group" {
  name     = "changeme-simple-kubernetes-cluster-resource-group"
  location = "West Europe"
}

# Kubernetes Cluster within the Resource Group
# Documentation: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster
resource "azurerm_kubernetes_cluster" "changeme_simple_kubernetes_cluster" {
  name                = "changeme-simple-kubernetes-cluster"
  location            = azurerm_resource_group.changeme_simple_kubernetes_cluster_resource_group.location
  resource_group_name = azurerm_resource_group.changeme_simple_kubernetes_cluster_resource_group.name

  dns_prefix = "changeme-simple-kubernetes-cluster-dns-prefix"

  identity {
    type = "SystemAssigned"
  }

  default_node_pool {
    name       = "changeme"
    node_count = 1
    vm_size    = "B1ls"
  }
}
