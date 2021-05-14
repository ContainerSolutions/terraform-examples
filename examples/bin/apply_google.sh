#!/bin/bash

cd "${0%/*}" || exit 1
source ./shared_google.sh
cd -

terraform init
terraform plan
if [[ $- == *i* ]]
then
  terraform apply
else
  terraform apply -auto-approve
fi
