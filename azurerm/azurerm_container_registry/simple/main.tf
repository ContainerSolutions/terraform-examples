# Summary: A simple Azure Container Registry

# Documentation: https://www.terraform.io/docs/language/settings/index.html
terraform {
  required_version = ">= 1.0.0"
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
resource "azurerm_resource_group" "changeme_simple_container_registry_resource_group" {
  name     = "changeme-simple-container-registry-resource-group"
  location = "West Europe"
}

# Container Registry within the Resource Group
# Documentation: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry
resource "azurerm_container_registry" "changeme_simple_container_registry" {
  name                = "changemesimplecontainerregistry"
  resource_group_name = azurerm_resource_group.changeme_simple_container_registry_resource_group.name
  location            = azurerm_resource_group.changeme_simple_container_registry_resource_group.location
  sku                 = "Standard"
}
