#!/bin/bash

# Move to the folder this script is in.
cd "${0%/*}" || exit 1

# shellcheck disable=SC1091
source ../../bin/shared.sh

log "Cleaning up aws_vpc"
terraform destroy -auto-approve 2>/dev/null || true
rm -rvf .terraform .terraform.lock.hcl terraform*
