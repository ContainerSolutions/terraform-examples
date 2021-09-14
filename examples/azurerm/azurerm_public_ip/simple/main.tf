# Summary: A simple Azure Public IP

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
resource "azurerm_resource_group" "changeme_simple_public_ip_resource_group" {
  name     = "changeme-simple-public-ip-resource-group-name"
  location = "West Europe"
}

# Public IP within the Resource Group
# Explanation: Note that the location of the Public IP does not need to match the location of the Resource Group
# Documentation: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip
resource "azurerm_public_ip" "changeme_simple_public_ip" {
  name                = "changeme-simple-load-balancer-public-ip-name"
  location            = "West US"
  resource_group_name = azurerm_resource_group.changeme_simple_public_ip_resource_group.name
  allocation_method   = "Static"
}
