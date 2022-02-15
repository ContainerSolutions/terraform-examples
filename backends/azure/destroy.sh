#!/bin/bash

# Move to the folder this script is in.
cd "${0%/*}" || exit 1

# shellcheck disable=SC1091
source ../../bin/shared.sh

log "Cleaning up azurerm_virtual_network"
cd azurerm_virtual_network || exit 1
rm -f main.tf
./destroy.sh 2>/dev/null || rm -rf .terraform terraform*
log "Cleaning up azurerm_storage_container"
cd ../azurerm_storage_container || exit 1
terraform destroy -auto-approve
