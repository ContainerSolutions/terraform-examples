#!/bin/bash

set -o errexit
set -o pipefail
set -o nounset

# Move to the folder this script is in.
cd "${0%/*}"

# shellcheck disable=SC1091
source ../../bin/shared.sh

log "Set up bucket..."
cd google_storage_bucket
./run.sh

BUCKET_NAME="$(terraform show -no-color | grep -w name | awk '{print $NF}')"
export BUCKET_NAME
log "Bucket name is: ${BUCKET_NAME}"
cd -

cd google_compute_network
log "Setting up Terraform code from main_template in google_compute_network..."
# shellcheck disable=SC2016
envsubst '$BUCKET_NAME' < "main_template" > "main.tf"

log "Set up vpc, storing state in backend..."
./run.sh
cd -
