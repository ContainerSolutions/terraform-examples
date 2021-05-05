#!/bin/bash

set -o errexit
set -o nounset

cd "${0%/*}/.."

echo "================================================================================"
echo "Checking that every folder has working scripts"
echo "================================================================================"
TERRAFORM_FOLDERS="$(find . | grep tf$ | xargs -n1 dirname | sed 's/^.\///')"
for folder in ${TERRAFORM_FOLDERS}
do
  echo -n "Checking folder: ${folder} ... "
  pushd "${folder}" >/dev/null
  for script in run.sh destroy.sh
  do
    echo -n "script:${script}... "
    if ! [ -e "${script}" ]
    then
      echo "$folder/$script should exist, but does not"
      exit 1
    fi
    FILES="$(grep '\.sh$' ${script})"
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
  echo done.
  popd >/dev/null
done
