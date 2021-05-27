#!/bin/bash

cd "${0%/*}" || exit 1
# shellcheck disable=SC1091
source ./shared_aws.sh
cd -

terraform init
terraform plan

# If this is non-interactive, then auto-approve...
if [[ $- == *i* ]]
then
  terraform destroy
else
  terraform destroy -auto-approve
fi
