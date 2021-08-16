# Summary: A simple Azure CosmosDB Cassandra Keyspace
# Explanation: A Cassandra Keyspace is equivalent to a Database in RDBMS's

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
resource "azurerm_resource_group" "changeme_simple_cosmosdb_cassandra_keyspace_resource_group" {
  name     = "changeme-simple-cosmosdb-cassandra-keyspace-resource-group"
  location = "West Europe"
}

# CosmosDB account in the Resource Group
# Documentation: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_account
# Explanation: Cassandra API must be explicitly enabled at the account level
resource "azurerm_cosmosdb_account" "changeme_simple_cosmosdb_cassandra_keyspace_cosmosdb_account" {
  name                = "changeme-simple-cck-cosmosdb-account-name"
  location            = azurerm_resource_group.changeme_simple_cosmosdb_cassandra_keyspace_resource_group.location
  resource_group_name = azurerm_resource_group.changeme_simple_cosmosdb_cassandra_keyspace_resource_group.name
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"

  geo_location {
    location          = azurerm_resource_group.changeme_simple_cosmosdb_cassandra_keyspace_resource_group.location
    failover_priority = 0
  }

  capabilities {
    name = "EnableCassandra"
  }

  consistency_policy {
    consistency_level       = "BoundedStaleness"
    max_interval_in_seconds = 10
    max_staleness_prefix    = 200
  }
}

# Cassandra Keyspace in the CosmosDB Account
# Explanation: Throughput is optional, but recommended since it can't be changed by Terraform if not set at creation
# Documentation: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_cassandra_keyspace
resource "azurerm_cosmosdb_cassandra_keyspace" "changeme_simple_cosmosdb_cassandra_keyspace" {
  name                = "changeme-simple-cosmosdb-cassandra-keyspace-name"
  resource_group_name = azurerm_resource_group.changeme_simple_cosmosdb_cassandra_keyspace_resource_group.name
  account_name        = azurerm_cosmosdb_account.changeme_simple_cosmosdb_cassandra_keyspace_cosmosdb_account.name
  throughput          = 400
}
