# Summary: A simple Azure Virtual Machine (deprecated in favor of the Linux and Windows specific resources)

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
resource "azurerm_resource_group" "changeme_simple_virtual_machine_windows_resource_group" {
  name     = "changeme-simple-virtual-machine-windows-resource-group-name"
  location = "West Europe"
}

# Virtual Network within the Resource Group
# Documentation: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network
resource "azurerm_virtual_network" "changeme_simple_virtual_machine_windows_virtual_network" {
  name                = "changeme-simple-virtual-machine-windows-virtual-network-name"
  resource_group_name = azurerm_resource_group.changeme_simple_virtual_machine_windows_resource_group.name
  location            = azurerm_resource_group.changeme_simple_virtual_machine_windows_resource_group.location
  address_space       = ["10.0.0.0/16"]
}

# Subnet within the Virtual Network
# Documentation: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet
resource "azurerm_subnet" "changeme_simple_virtual_machine_windows_subnet" {
  name                 = "changeme-simple-virtual-machine-windows-subnet-name"
  resource_group_name  = azurerm_resource_group.changeme_simple_virtual_machine_windows_resource_group.name
  virtual_network_name = azurerm_virtual_network.changeme_simple_virtual_machine_windows_virtual_network.name
  address_prefixes     = ["10.0.1.0/24"]
}

# NIC attached to the Subnet
# Documentation: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface
resource "azurerm_network_interface" "changeme_simple_virtual_machine_windows_network_interface" {
  name                = "changeme-simple-virtual-machine-windows-network-interface-name"
  location            = azurerm_resource_group.changeme_simple_virtual_machine_windows_resource_group.location
  resource_group_name = azurerm_resource_group.changeme_simple_virtual_machine_windows_resource_group.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.changeme_simple_virtual_machine_windows_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Virtual Machine (Windows) with the NIC attached
# Documentation: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources_virtual_machine
resource "azurerm_virtual_machine" "changeme_simple_virtual_machine_windows" {
  name                  = "changeme-simple-virtual-machine-windows-name"
  resource_group_name   = azurerm_resource_group.changeme_simple_virtual_machine_windows_resource_group.name
  location              = azurerm_resource_group.changeme_simple_virtual_machine_windows_resource_group.location
  vm_size               = "Standard_B1ls"
  network_interface_ids = [azurerm_network_interface.changeme_simple_virtual_machine_windows_network_interface.id]

  storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter-Core-smalldisk"
    version   = "latest"
  }

  storage_os_disk {
    name              = "changeme-os-disk-name"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
    os_type           = "Windows"
  }

  os_profile {
    computer_name  = "changeme-simple"
    admin_username = "changeme"
    admin_password = "Password1234!"
  }

  os_profile_windows_config {}
}
