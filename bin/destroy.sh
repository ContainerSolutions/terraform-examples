#!/bin/bash

# Also deletes all the files created by terraform with this script with conjunction of clean_up.sh

SUPPORTED_PROVIDERS="aws|azurerm|digitalocean|google|kubernetes|linode"
if [[ -n "$1" && ! "$1" =~ ${SUPPORTED_PROVIDERS} ]]
then
  echo "usage: $0 [PROVIDER]"
  echo "  PROVIDER := {${SUPPORTED_PROVIDERS}}"
  exit 1
fi

cd "${0%/*}" || exit 1

echo $pwd

if [ -z "$1" ]
then
  # shellcheck disable=SC1091
  source ./shared.sh
else
  # shellcheck disable=SC1091
  # shellcheck source=shared_aws.sh
  source "./shared_${1}.sh"
fi
# shellcheck disable=SC1091
source ./shared_terraform_cloud.sh

cd - || exit 1

terraform init
terraform plan

# If this is non-interactive, then auto-approve...
if [[ $- == *i* ]]
then
  terraform destroy
else
  terraform destroy -auto-approve
fi

cd "${0%/*}" || exit 1

source ./clean_up.sh