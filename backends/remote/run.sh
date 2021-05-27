#!/bin/bash

# Move to the folder this script is in.
cd "${0%/*}" || exit 1

# shellcheck disable=SC1091
source ../../bin/shared.sh

log "Destroying any pre-existing runs..."
./destroy.sh

log "Setting up Terraform code in aws_vpc..."
log "Set up vpc, storing state in backend..."
terraform init
terraform plan
terraform apply -auto-approve
