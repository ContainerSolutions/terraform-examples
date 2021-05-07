#!/bin/bash

# Move to the folder this script is in.
cd "${0%/*}" || exit 1

# shellcheck disable=SC1091
source ../../bin/shared.sh

log "Destroying any pre-existing runs..."
./destroy.sh

log "Set up bucket..."
cd aws_s3_bucket || exit 1
# shellcheck disable=SC1091
source run.sh
terraform init
terraform plan
terraform apply -auto-approve
BUCKET_NAME="$(terraform show -no-color | grep -w bucket | awk '{print $NF}')"
log "Bucket name is: ${BUCKET_NAME}"
cd ../aws_vpc || exit 1
log "Setting up Terraform code from main_template in aws_vpc..."
sed "s/BUCKET_NAME/${BUCKET_NAME}/g" main_template > main.tf
log "Set up vpc, storing state in backend..."
terraform init
terraform plan
terraform apply
