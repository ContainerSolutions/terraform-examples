# Summary: A simple Azure Network Security Rule

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
resource "azurerm_resource_group" "changeme_simple_network_security_rule_resource_group_resource_group" {
  name     = "changeme-simple-nsrule-resource-group"
  location = "West Europe"
}


# Network Security Group within the Resource Group
# Documentation: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group
resource "azurerm_network_security_group" "changeme_simple_network_security_rule_resource_group" {
  name                = "changeme-simple-network-security-group"
  resource_group_name = azurerm_resource_group.changeme_simple_network_security_rule_resource_group_resource_group.name
  location            = azurerm_resource_group.changeme_simple_network_security_rule_resource_group_resource_group.location
}


# Network Security Rule attached to Network Security Group
# Documentation: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule
resource "azurerm_network_security_rule" "changeme_simple_network_security_rule" {
  name                        = "changeme-simple-network-security-rule-allow-HTTP-in"
  priority                    = 100
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.changeme_simple_network_security_rule_resource_group_resource_group.name
  network_security_group_name = azurerm_network_security_group.changeme_simple_network_security_rule_resource_group.name
}