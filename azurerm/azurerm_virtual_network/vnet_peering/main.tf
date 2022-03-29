# Summary: A simple Azure Virtual Machine (deprecated in favor of the Linux and Windows specific resources)

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
resource "azurerm_resource_group" "changeme_simple_vnet_peering_group" {
  name     = "changeme-simple-vnet-peering-group"
  location = "West Europe"
}

# Virtual Network within the Resource Group
# Documentation: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network
resource "azurerm_virtual_network" "changeme_vnet_1" {
  name                = "changeme_vnet_1"
  resource_group_name = azurerm_resource_group.changeme_simple_vnet_peering_group.name
  address_space       = ["10.0.1.0/24"]
  location            = "West US"
}

resource "azurerm_virtual_network" "changeme_vnet_2" {
  name                = "changeme_vnet_2"
  resource_group_name = azurerm_resource_group.changeme_simple_vnet_peering_group.name
  address_space       = ["10.0.2.0/24"]
  location            = "West US"
}

#Virtual Network Peering connectoion between both Vnets
#Documentation: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_peering
resource "azurerm_virtual_network_peering" "changeme_peer12" {
  name                      = "changeme_peer12"
  resource_group_name       = azurerm_resource_group.changeme_simple_vnet_peering_group.name
  virtual_network_name      = azurerm_virtual_network.changeme_vnet_1.name
  remote_virtual_network_id = azurerm_virtual_network.changeme_vnet_2.id
}

resource "azurerm_virtual_network_peering" "changeme_peer21" {
  name                      = "changeme_peer21"
  resource_group_name       = azurerm_resource_group.changeme_simple_vnet_peering_group.name
  virtual_network_name      = azurerm_virtual_network.changeme_vnet_2.name
  remote_virtual_network_id = azurerm_virtual_network.changeme_vnet_1.id
}