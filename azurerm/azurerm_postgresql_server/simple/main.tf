# Summary: A simple Azure PostgreSQL Server

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
resource "azurerm_resource_group" "changeme_simple_postgresql_server_resource_group" {
  name     = "changeme-simple-postgresql-database-resource-group"
  location = "West Europe"
}

# PostgreSQL Server within the Resource Group
# Documentation: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_server
resource "azurerm_postgresql_server" "changeme_simple_postgresql_server" {
  name                = "changeme-simple-postgresql-database-name"
  resource_group_name = azurerm_resource_group.changeme_simple_postgresql_server_resource_group.name
  location            = azurerm_resource_group.changeme_simple_postgresql_server_resource_group.location

  sku_name = "B_Gen5_1"
  version  = "11"

  administrator_login          = "changemeadmin"
  administrator_login_password = "ch4ng3m3-A@£$%^&"

  ssl_enforcement_enabled = true
}
