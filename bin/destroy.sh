#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null || exit 1
# shellcheck disable=SC1091
source ./shared.sh
# shellcheck disable=SC1091
source ./shared_terraform_cloud.sh
cd - >/dev/null || exit 1

terraform init
terraform plan

# If this is non-interactive, then auto-approve...
if [[ $- == *i* ]]
then
  terraform destroy
else
  terraform destroy -auto-approve
fi
