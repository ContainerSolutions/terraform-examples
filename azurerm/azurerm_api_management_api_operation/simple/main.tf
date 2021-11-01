# Summary: A simple Azure Load Balancer

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
resource "azurerm_resource_group" "changeme_simple_api_management_api_operation_resource_group" {
  name     = "changeme-simple-api-management-api-operation-resource-group-name"
  location = "West Europe"
}

# API Management Service
# Documentation: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management
resource "azurerm_api_management" "changeme_simple_api_management_api_operation_api_management" {
  name                = "changeme-simple-apim-api-operation-apim-name"
  location            = "West Europe"
  resource_group_name = azurerm_resource_group.changeme_simple_api_management_api_operation_resource_group.name

  publisher_name  = "changeme-publisher"
  publisher_email = "changeme-publisher@example.com"

  sku_name = "Developer_1"
}

# API within an API Management Service
# Documentation: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api
resource "azurerm_api_management_api" "changeme_simple_api_management_api_operation_api_management_api" {
  api_management_name = azurerm_api_management.changeme_simple_api_management_api_operation_api_management.name
  resource_group_name = azurerm_resource_group.changeme_simple_api_management_api_operation_resource_group.name

  name = "changeme-simple-api-management-operation-api-management-api-name"

  revision = "changeme-revision-number"
}

# API Operation within an API Management Service
# Documentation: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_operation
resource "azurerm_api_management_api_operation" "changeme_simple_api_management_api_operation" {
  api_management_name = azurerm_api_management.changeme_simple_api_management_api_operation_api_management.name
  api_name            = azurerm_api_management_api.changeme_simple_api_management_api_operation_api_management_api.name
  resource_group_name = azurerm_resource_group.changeme_simple_api_management_api_operation_resource_group.name

  display_name = "changeme-simple-api-management-api-operation-display-name"

  method       = "GET"
  operation_id = "changeme-simple-api-management-api-operation-operation-id"
  url_template = "changeme-simple-api-management-api-operation-url-template"
}