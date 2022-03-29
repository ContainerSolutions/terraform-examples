# Summary: An example of mapping n-many security rules to an Azure Network Security Rule

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

variable "changeme_network_security_rules" {
  type = list(any)
  default = [
    { name = "HTTPS" },
    { name = "HTTP" },
    { name = "SSH" }
  ]
}

variable "changeme_rules" {
  description = "Standard set of predefined rules, in this example it allows inbound traffic from anywhere to ports 22, 80 and 443"
  type        = map(any)
  default = {
    # [direction, access, protocol, source_port_range, destination_port_range, source_address_prefix, destination_address_prefix, description]"
    HTTPS = ["Inbound", "Allow", "TCP", "*", "433", "*", "*", "HTTPS"]
    HTTP  = ["Inbound", "Allow", "TCP", "*", "80", "*", "*", "HTTP"]
    SSH   = ["Inbound", "Allow", "TCP", "*", "22", "*", "*", "SSH"]
  }
}

# Documentation: https://www.terraform.io/docs/language/providers/requirements.html
# Documentation: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs
provider "azurerm" {
  features {}

  subscription_id = var.azure_subscription_id
}

# Resource Group
# Documentation: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group
resource "azurerm_resource_group" "changeme_network_security_rule_resource_group" {
  name     = "changeme-iterative-nsrule-resource-group"
  location = "West Europe"
}


# Network Security Group within the Resource Group
# Documentation: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group
resource "azurerm_network_security_group" "changeme_network_security_group" {
  name                = "changeme-simple-network-security-group"
  resource_group_name = azurerm_resource_group.changeme_network_security_rule_resource_group.name
  location            = azurerm_resource_group.changeme_network_security_rule_resource_group.location
}


# Network Security Rule attached to Network Security Group
# Documentation: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule
# Explanation: Mapping values provided in variables allows to create only one Network Security RUle resource in the code, 
# and then populate it with n-many values from variables, as opposed to creating a separate entry for each rule.

resource "azurerm_network_security_rule" "changeme_network_security_rule" {
  count                       = length(var.changeme_network_security_rules)
  name                        = lookup(var.changeme_network_security_rules[count.index], "name")
  priority                    = lookup(var.changeme_network_security_rules[count.index], "priority", "${100 + (count.index + 10)}")
  direction                   = element(var.changeme_rules["${lookup(var.changeme_network_security_rules[count.index], "name")}"], 0)
  access                      = element(var.changeme_rules["${lookup(var.changeme_network_security_rules[count.index], "name")}"], 1)
  protocol                    = element(var.changeme_rules["${lookup(var.changeme_network_security_rules[count.index], "name")}"], 2)
  source_port_range           = element(var.changeme_rules["${lookup(var.changeme_network_security_rules[count.index], "name")}"], 3)
  destination_port_range      = element(var.changeme_rules["${lookup(var.changeme_network_security_rules[count.index], "name")}"], 4)
  source_address_prefix       = element(var.changeme_rules["${lookup(var.changeme_network_security_rules[count.index], "name")}"], 5)
  destination_address_prefix  = element(var.changeme_rules["${lookup(var.changeme_network_security_rules[count.index], "name")}"], 6)
  resource_group_name         = azurerm_resource_group.changeme_network_security_rule_resource_group.name
  network_security_group_name = azurerm_network_security_group.changeme_network_security_group.name
}