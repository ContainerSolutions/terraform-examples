This example sets up an Azure Storage backend with a minimal example of a state stored in it.

It:

- Creates an Azure Storage account with a random name ('changemexxxxxxxxxxxxx') and a Container ('changemebackendazure')

- Sets up an Azure Virtual Network, storing state in that backend

These are the files used:

`destroy.sh`                               - Shell script to clean up any previous run of `run.sh`

`run.sh`                                   - Run this whole example up, creating the Container, backend, and Azure Virtual Network

`azurerm_storage_container/main.tf`        - Terraform code to set up a Container

`azurerm_storage_container/run.sh`         - Script to create just the Container

`azurerm_storage_container/destroy.sh`     - Script to destroy just the Container

`azurerm_virtual_network/main_template`    - Template file for Terraform code for Azure Virtual Network

