# Summary: An empty Azure Managed Disk

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
resource "azurerm_resource_group" "changeme_empty_managed_disk_resource_group" {
  name     = "changeme-empty-storage-table-resource-group"
  location = "West Europe"
}

# Managed Disk in the Storage Account
# Explanation: Managed Disks are housed in a managed Storage Account that can not be otherwise accessed
# Documentation: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/managed_disk
resource "azurerm_managed_disk" "changeme_empty_managed_disk" {
  name     = "changeme-empty-managed-disk-name"
  location = "West US"

  disk_size_gb = "1"

  create_option        = "Empty"
  resource_group_name  = azurerm_resource_group.changeme_empty_managed_disk_resource_group.name
  storage_account_type = "Standard_LRS"
}