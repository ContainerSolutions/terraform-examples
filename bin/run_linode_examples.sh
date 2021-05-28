#!/bin/bash

set -o errexit
set -o nounset

cd "${0%/*}/.."

# shellcheck disable=SC1091
source bin/get_linode_folders.sh
for folder in ${LINODE_FOLDERS}
do
  echo "================================================================================"
  echo -n "Checking folder: ${folder} ... "
  if [[ -a ${folder}/.skiptest ]]
  then
    echo -n "found .skiptest file, skipping "
    continue
  fi
  pushd "${folder}" >/dev/null
  echo -n "./run.sh"
  ./run.sh
  echo -n "./destroy.sh"
  ./destroy.sh
  popd >/dev/null
done
