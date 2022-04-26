# Summary:
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
resource "azurerm_resource_group" "changeme_linux_scaleset_resource_group" {
  name     = "changeme-linux-scaleset-resource-group-name"
  location = "West Europe"
}


# Virtual Network within the Resource Group
# Documentation: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network
resource "azurerm_virtual_network" "changeme_simple_virtual_machine_linux_virtual_network" {
  name                = "changeme-simple-virtual-machine-linux-virtual-network-name"
  resource_group_name = azurerm_resource_group.changeme_linux_scaleset_resource_group.name
  location            = azurerm_resource_group.changeme_linux_scaleset_resource_group.location
  address_space       = ["10.0.0.0/16"]
}

# Subnet within the Virtual Network
# Documentation: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet
resource "azurerm_subnet" "changeme_simple_virtual_machine_linux_subnet" {
  name                 = "changeme-simple-virtual-machine-linux-subnet-name"
  resource_group_name  = azurerm_resource_group.changeme_linux_scaleset_resource_group.name
  virtual_network_name = azurerm_virtual_network.changeme_simple_virtual_machine_linux_virtual_network.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_linux_virtual_machine_scale_set" "changeme_simple_virtual_machine_linux_scaleset" {
  name                            = "changeme-simple-virtual-machine-linux-scaleset"
  resource_group_name             = azurerm_resource_group.changeme_linux_scaleset_resource_group.name
  location                        = azurerm_resource_group.changeme_linux_scaleset_resource_group.location
  sku                             = "Standard_F2"
  instances                       = 2
  admin_username                  = "changeme"
  admin_password                  = "Changeme123#"
  disable_password_authentication = false

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "Latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }


  network_interface {
    name    = "changeme-network-interface-name"
    primary = true

    ip_configuration {
      name      = "changeme-internal-ip-config"
      primary   = true
      subnet_id = azurerm_subnet.changeme_simple_virtual_machine_linux_subnet.id
    }
  }
}