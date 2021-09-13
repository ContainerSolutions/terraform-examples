# Summary: A Management Group as a child of another Management Group

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

# Parent Management Group
# Documentation: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group
resource "azurerm_management_group" "changeme_parent_management_group" {
  display_name = "changeme-parent-management-group-display-name"
}

# Management Group attached as a child to another Management Group
# Documentation: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group
resource "azurerm_management_group" "changeme_child_management_group" {
  display_name               = "changeme-child-management-group-display-name"
  parent_management_group_id = azurerm_management_group.changeme_parent_management_group.id
}
