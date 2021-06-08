#!/bin/bash

set -o errexit
set -o nounset

cd "${0%/*}/.."

export TF_VAR_azure_subscription_id="$ARM_SUBSCRIPTION_ID"

# shellcheck disable=SC1091
source bin/get_azurerm_folders.sh
for folder in ${AZURERM_FOLDERS}
do
  echo "================================================================================"
  echo -n "Checking folder: ${folder} ... "
  pushd "${folder}" >/dev/null
  echo -n "./run.sh"
  # If the run fails, try and clean up
  ./run.sh || ( ./destroy.sh && exit 1 )
  echo -n "./destroy.sh"
  ./destroy.sh
  popd >/dev/null
done
