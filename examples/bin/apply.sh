#!/bin/bash

cd "$(dirname ${BASH_SOURCE[0]})" || exit 1
source ./shared.sh
cd -

terraform init
terraform plan
terraform apply
