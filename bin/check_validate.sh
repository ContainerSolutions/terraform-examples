#!/bin/bash

set -o errexit
set -o nounset

cd "${0%/*}"
# shellcheck disable=SC1091
source ./shared_terraform_cloud.sh

cd "${0%/*}/.."


echo "================================================================================"
echo "Validating every folder's terraform code"
echo "================================================================================"
TERRAFORM_FOLDERS="$(find . | grep tf$ | xargs -n1 dirname | sed 's/^.\///')"
for folder in $TERRAFORM_FOLDERS
do
  echo "================================================================================"
  echo "Validating code in ${folder}"
  echo "================================================================================"
  if [ "${folder}" = "backends/remote" ] && [ ! -f "${HOME}/.terraform.d/credentials.tfrc.json" ]
  then
    echo "Skipping validate in ${folder} as it requires 'terraform login'"
    continue
  fi
  cd "${folder}" >/dev/null || exit 1
  terraform init
  terraform validate
  cd - >/dev/null || exit 1
done
