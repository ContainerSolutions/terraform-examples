# Summary: An copy Azure Managed Disk created form another Azure Managed Disk

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
resource "azurerm_resource_group" "changeme_copy_managed_disk_resource_group" {
  name     = "changeme-copy-storage-table-resource-group"
  location = "West Europe"
}

# Managed Disk in the Resource Group
# Explanation: Managed Disks are housed in a managed Storage Account that can not be otherwise accessed
# Documentation: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/managed_disk
resource "azurerm_managed_disk" "changeme_copy_managed_disk_template_managed_disk" {
  name     = "changeme-copy-managed-disk-template-managed-disk-name"
  location = "West US"

  disk_size_gb = "1"

  create_option        = "Empty"
  resource_group_name  = azurerm_resource_group.changeme_copy_managed_disk_resource_group.name
  storage_account_type = "Standard_LRS"
}

# Managed Disk copied from another Managed Disk in the same Resource Group
# Documentation: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/managed_disk
resource "azurerm_managed_disk" "changeme_copy_managed_disk" {
  name     = "changeme-copy-managed-disk-name"
  location = "West US"

  source_resource_id = azurerm_managed_disk.changeme_copy_managed_disk_template_managed_disk.id

  create_option        = "Copy"
  resource_group_name  = azurerm_resource_group.changeme_copy_managed_disk_resource_group.name
  storage_account_type = "Standard_LRS"
}