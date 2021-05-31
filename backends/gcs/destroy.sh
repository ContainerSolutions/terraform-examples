#!/bin/bash

set -o errexit
set -o pipefail
set -o nounset

# Move to the folder this script is in.
cd "${0%/*}"

# shellcheck disable=SC1091
source ../../bin/shared.sh

log "Cleaning up google_compute_network"
cd google_compute_network
./destroy.sh 2>/dev/null || true
rm -f main.tf
rm -rf .terraform terraform*

log "Cleaning up google_storage_bucket"
cd -
cd google_storage_bucket
./destroy.sh
cd -
