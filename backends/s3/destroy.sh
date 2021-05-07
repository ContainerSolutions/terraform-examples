#!/bin/bash

# Move to the folder this script is in.
cd "${0%/*}" || exit 1

# shellcheck disable=SC1091
source ../../bin/shared.sh

log "Cleaning up aws_vpc"
cd aws_vpc || exit 1
rm -f main.tf
./destroy.sh 2>/dev/null || rm -rf .terraform terraform*
log "Cleaning up aws_s3_bucket"
cd ../aws_s3_bucket || exit 1
terraform destroy -auto-approve
