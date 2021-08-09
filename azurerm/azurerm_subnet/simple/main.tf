# Summary: A simple Azure Linux Virtual Machine

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
resource "azurerm_resource_group" "changeme_simple_subnet_resource_group" {
  name     = "changeme-simple-resource-group"
  location = "West Europe"
}

# Virtual Network within the Resource Group
# Documentation: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network
resource "azurerm_virtual_network" "changeme_simple_subnet_virtual_network" {
  name                = "changeme-simple-virtual-network"
  resource_group_name = azurerm_resource_group.changeme_simple_subnet_resource_group.name
  location            = azurerm_resource_group.changeme_simple_subnet_resource_group.location
  address_space       = ["10.0.0.0/16"]
}

# Subnet within the Virtual Network
# Documentation: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet
resource "azurerm_subnet" "changeme_simple_subnet" {
  name                 = "changeme-simple-subnet"
  resource_group_name  = azurerm_resource_group.changeme_simple_subnet_resource_group.name
  virtual_network_name = azurerm_virtual_network.changeme_simple_subnet_virtual_network.name
  address_prefixes     = ["10.0.1.0/24"]
}