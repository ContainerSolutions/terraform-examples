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
resource "azurerm_resource_group" "changeme_simple_virtual_machine_linux_resource_group" {
  name     = "changeme-simple-virtual-machine-linux-resource-group-name"
  location = "West Europe"
}

# Virtual Network within the Resource Group
# Documentation: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network
resource "azurerm_virtual_network" "changeme_simple_virtual_machine_linux_virtual_network" {
  name                = "changeme-simple-virtual-machine-linux-virtual-network-name"
  resource_group_name = azurerm_resource_group.changeme_simple_virtual_machine_linux_resource_group.name
  location            = azurerm_resource_group.changeme_simple_virtual_machine_linux_resource_group.location
  address_space       = ["10.0.0.0/16"]
}

# Subnet within the Virtual Network
# Documentation: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet
resource "azurerm_subnet" "changeme_simple_virtual_machine_linux_subnet" {
  name                 = "changeme-simple-virtual-machine-linux-subnet-name"
  resource_group_name  = azurerm_resource_group.changeme_simple_virtual_machine_linux_resource_group.name
  virtual_network_name = azurerm_virtual_network.changeme_simple_virtual_machine_linux_virtual_network.name
  address_prefixes     = ["10.0.1.0/24"]
}

# NIC attached to the Subnet
# Documentation: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface
resource "azurerm_network_interface" "changeme_simple_virtual_machine_linux_network_interface" {
  name                = "changeme-simple-virtual-machine-linux-network-interface-name"
  location            = azurerm_resource_group.changeme_simple_virtual_machine_linux_resource_group.location
  resource_group_name = azurerm_resource_group.changeme_simple_virtual_machine_linux_resource_group.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.changeme_simple_virtual_machine_linux_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Virtual Machine (Linux) with the NIC attached
# Documentation: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources_virtual_machine
resource "azurerm_virtual_machine" "changeme_simple_virtual_machine_linux" {
  name                  = "changeme-simple-virtual-machine-linux-name"
  resource_group_name   = azurerm_resource_group.changeme_simple_virtual_machine_linux_resource_group.name
  location              = azurerm_resource_group.changeme_simple_virtual_machine_linux_resource_group.location
  vm_size               = "Standard_B1ls"
  network_interface_ids = [azurerm_network_interface.changeme_simple_virtual_machine_linux_network_interface.id]

  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name              = "changeme-os-disk-name"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "changeme-simple"
    admin_username = "changeme"
    admin_password = "Password1234!"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}
