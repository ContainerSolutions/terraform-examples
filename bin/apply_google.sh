#!/bin/bash

cd "${0%/*}" || exit 1
source ./shared_google.sh
source ./shared_terraform_cloud.sh
cd -

terraform init
terraform plan

# If this is non-interactive, then auto-approve...
if [[ $- == *i* ]]
then
  terraform apply
else
  terraform apply -auto-approve
fi
