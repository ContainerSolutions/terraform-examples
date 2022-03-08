# Summary: A simple Azure Storage Container for Storage Blobs

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

# Explanation: This resource is not necessary for the creation of a Key Vault service, but is here to ensure that
# the name is unique.
#
# Documentation: https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id
resource "random_id" "changeme_simple_key_vault_name" {
  byte_length = 8
}

# Resource Group
# Documentation: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group
resource "azurerm_resource_group" "changeme_simple_key_vault_resource_group" {
  name     = "changeme-simple-key-vault-resource-group"
  location = "West Europe"
}

# Client Config Data Source
# Documentation: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config
data "azurerm_client_config" "changeme_current" {}


# Azure Key Vault
# Documentation: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault
resource "azurerm_key_vault" "changeme_simple_key_vault" {
  name                = "changeme${random_id.changeme_simple_key_vault_name.hex}"
  location            = azurerm_resource_group.changeme_simple_key_vault_resource_group.location
  resource_group_name = azurerm_resource_group.changeme_simple_key_vault_resource_group.name
  tenant_id           = data.azurerm_client_config.changeme_current.tenant_id
  sku_name            = "standard"
}
