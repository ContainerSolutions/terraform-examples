#!/bin/bash

cd "${0%/*}" || exit 1
source ./shared_kubernetes.sh
cd -

terraform init
terraform plan
if [[ $- == *i* ]]
then
  terraform destroy
else
  terraform destroy -auto-approve
fi
