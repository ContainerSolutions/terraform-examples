# Summary: A simple Azure Storage Share for filesystem storage

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
resource "azurerm_resource_group" "changeme_simple_storage_share_resource_group" {
  name     = "changeme-simple-storage-share-resource-group"
  location = "West Europe"
}

# Storage Account within the Resource Group
# Documentation: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account
resource "azurerm_storage_account" "changeme_simple_storage_share_storage_account" {
  name                     = "changemesimpleqsaname"
  resource_group_name      = azurerm_resource_group.changeme_simple_storage_share_resource_group.name
  location                 = azurerm_resource_group.changeme_simple_storage_share_resource_group.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Storage Share in the Storage Account
# Documentation: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_share
resource "azurerm_storage_share" "changeme_simple_storage_share" {
  name                 = "changemesimplesharename"
  storage_account_name = azurerm_storage_account.changeme_simple_storage_share_storage_account.name
}