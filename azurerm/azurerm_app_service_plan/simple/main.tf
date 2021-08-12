# Summary: A simple Azure App Service Plan

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
resource "azurerm_resource_group" "changeme_simple_app_service_plan_resource_group" {
  name     = "changeme-simple-app-service-plan-resource-group"
  location = "West Europe"
}

# Storage Account within the Resource Group
# Documentation: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account
resource "azurerm_storage_account" "changeme_simple_app_service_plan_storage_account" {
  name                     = "changemesimpleaspsaname"
  resource_group_name      = azurerm_resource_group.changeme_simple_app_service_plan_resource_group.name
  location                 = azurerm_resource_group.changeme_simple_app_service_plan_resource_group.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# App Service Plan within the Resource Group
# Documentation: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service_plan
resource "azurerm_app_service_plan" "changeme_simple_app_service_plan" {
  name                = "changeme-simple-app-service-plan-name"
  location            = azurerm_resource_group.changeme_simple_app_service_plan_resource_group.location
  resource_group_name = azurerm_resource_group.changeme_simple_app_service_plan_resource_group.name

  sku {
    tier = "Standard"
    size = "S1"
  }
}
