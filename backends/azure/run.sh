#!/bin/bash

# Move to the folder this script is in.
cd "${0%/*}" || exit 1

# shellcheck disable=SC1091
source ../../bin/shared.sh

log "Destroying any pre-existing runs..."
./destroy.sh

log "Set up Azure Storage Account and Container..."
cd azurerm_storage_container || exit 1
# shellcheck disable=SC1091
source run.sh
terraform init
terraform plan
terraform apply -auto-approve
ACCOUNT_NAME="$(terraform show | grep storage_account_name | awk '{print $NF}')"
log "Azure Storage account name is: ${ACCOUNT_NAME}"
cd ../azurerm_virtual_network || exit 1
log "Setting up Terraform code from main_template in azurerm_virtual_network..."
sed "s/ACCOUNT_NAME/${ACCOUNT_NAME}/g" main_template > main.tf
log "Set up virtual network, storing state in backend..."
terraform init
terraform plan
terraform apply -auto-approve
