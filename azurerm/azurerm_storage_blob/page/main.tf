# Summary: An Azure Storage Blob using Page storage

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
resource "azurerm_resource_group" "changeme_page_storage_blob_resource_group" {
  name     = "changeme-page-storage-blob-resource-group"
  location = "West Europe"
}

# Storage Account within the Resource Group
# Documentation: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account
resource "azurerm_storage_account" "changeme_page_storage_blob_storage_account" {
  name                     = "changemepagebsaname"
  resource_group_name      = azurerm_resource_group.changeme_page_storage_blob_resource_group.name
  location                 = azurerm_resource_group.changeme_page_storage_blob_resource_group.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Storage Container in the Storage Account
# Documentation: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container
resource "azurerm_storage_container" "changeme_page_storage_blob_storage_container" {
  name                 = "changemepagebsacname"
  storage_account_name = azurerm_storage_account.changeme_page_storage_blob_storage_account.name
}

# Page Storage Blob in the Storage Container
# Documentation: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_blob
resource "azurerm_storage_blob" "changeme_page_storage_blob" {
  name                   = "changemepageblobname"
  storage_account_name   = azurerm_storage_account.changeme_page_storage_blob_storage_account.name
  storage_container_name = azurerm_storage_container.changeme_page_storage_blob_storage_container.name
  type                   = "Page"
  size                   = 512
}