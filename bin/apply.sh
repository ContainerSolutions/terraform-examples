#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null || exit 1
# shellcheck disable=SC1091
source ./shared.sh
cd - >/dev/null || exit 1

terraform init
terraform plan
terraform apply
