# Summary: A simple Azure SQL Server

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
resource "azurerm_resource_group" "changeme_simple_sql_server_resource_group" {
  name     = "changeme-simple-sql-database-resource-group"
  location = "West Europe"
}

# SQL Server within the Resource Group
# Documentation: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/sql_server
resource "azurerm_sql_server" "changeme_simple_sql_server" {
  name                = "changeme-simple-sql-database-name"
  resource_group_name = azurerm_resource_group.changeme_simple_sql_server_resource_group.name
  location            = azurerm_resource_group.changeme_simple_sql_server_resource_group.location

  version = "12.0"

  administrator_login          = "changemeadmin"
  administrator_login_password = "ch4ng3m3-A@£$%^&"
}
