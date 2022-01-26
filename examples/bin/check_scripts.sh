#!/bin/bash

set -o errexit
set -o nounset

cd "${0%/*}/.."

echo "================================================================================"
echo "Checking that every folder has working scripts"
echo "================================================================================"
# shellcheck disable=SC1091
source bin/get_terraform_folders.sh
for folder in ${TERRAFORM_FOLDERS}
do
  echo -n "Checking folder: ${folder} ... "
  pushd "${folder}" >/dev/null
  for script in run.sh destroy.sh
  do
    echo -n "script:${script}... "
    if ! [ -x "${script}" ]
    then
      echo "$folder/$script should exist and be executable, but is/does not"
      popd
      ls -l "${folder}"
      exit 1
    fi
    FILES="$(grep '\.sh$' ${script} | awk '{print $NF}')"
    echo -n "file:${script}... "
    for file in ${FILES}
    do
      if ! [ -e "${file}" ]
      then
        echo "File ${file} mentioned in ${folder}/${script} does not exist"
        exit 1
      fi
    done
  done
  echo 'OK! Done.'
  popd >/dev/null
done
