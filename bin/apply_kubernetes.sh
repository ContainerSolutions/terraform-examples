#!/bin/bash

cd "${0%/*}" || exit 1
source ./shared_kubernetes.sh
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
