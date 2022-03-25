# Summary: Creates an Azure Storage account and a Container

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


# Explanation: This resource is not necessary for the creation of an Azure Storage Account, but is here to ensure that
# the Azure Account name is unique.
#
# Documentation: https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id
resource "random_id" "changeme_backends_azure_storage_name" {
  byte_length = 8
}

# Resource Group
# Documentation: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group
resource "azurerm_resource_group" "changeme_backends_azure_storage_resource_group" {
  name     = "changeme-azure-storage-container-resource-group"
  location = "East US"
}

# Storage Account within the Resource Group
# Documentation: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account
resource "azurerm_storage_account" "changeme_backends_azure_storage_account" {
  name                     = "changeme${random_id.changeme_backends_azure_storage_name.hex}"
  resource_group_name      = azurerm_resource_group.changeme_backends_azure_storage_resource_group.name
  location                 = azurerm_resource_group.changeme_backends_azure_storage_resource_group.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Storage Container in the Storage Account
# Documentation: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container
resource "azurerm_storage_container" "changeme_backends_azure_storage_container" {
  name                 = "changemebackendazure"
  storage_account_name = azurerm_storage_account.changeme_backends_azure_storage_account.name
}