#!/bin/bash

set -o errexit
set -o nounset

cd "${0%/*}/.."

if [[ $(terraform fmt -recursive -diff > fmt.out 2>&1) != '' ]]
then
  echo "Terraform fmt failed"
  cat fmt.out
  rm fmt.out
  exit 1
fi
