#!/bin/bash

cd "${0%/*}" || exit 1

# shellcheck disable=SC1091
source ./shared_linode.sh
# shellcheck disable=SC1091
source ./shared_terraform_cloud.sh

cd - || exit 1

terraform init
terraform plan

# If this is non-interactive, then auto-approve...
if [[ $- == *i* ]]
then
  terraform apply
else
  terraform apply -auto-approve
fi
