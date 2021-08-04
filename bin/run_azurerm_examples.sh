#!/bin/bash

set -o errexit
set -o nounset

cd "${0%/*}/.."

export TF_VAR_azure_subscription_id="$ARM_SUBSCRIPTION_ID"

last_successful_commit=$(./bin/get_last_successful_commit.sh)
changed_folders=$(./bin/get_changed_folders.sh)
# shellcheck disable=SC1091
source bin/get_azurerm_folders.sh
for folder in ${AZURERM_FOLDERS}
do
  echo "================================================================================"
  echo -n "$0 checking folder: ${folder} ... "
  if [[ -a ${folder}/.skiptest ]]
  then
    echo -n "found .skiptest file, skipping "
    continue
  fi
  if ! echo "${changed_folders}" | tr ' ' '\n' | grep "$folder"
  then
    if [[ -a azurerm/.forcetest ]]
    then
      echo "azurerm/.forcetest file exists, forcing test run"
    elif [[ -a ${folder}/.forcetest ]]
    then
      echo "${folder}/.forcetest file exists, forcing test run"
    else
      echo "Folder ${folder} has not changed since last successful test on main (${last_successful_commit})"
      continue
    fi
  fi
  pushd "${folder}" >/dev/null
  echo -n "./run.sh"
  # If the run fails, try and clean up
  ./run.sh || ( ./destroy.sh && exit 1 )
  echo -n "./destroy.sh"
  ./destroy.sh
  popd >/dev/null
done
