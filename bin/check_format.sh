#!/bin/bash

set -o errexit
set -o nounset

cd "${0%/*}/.."

terraform fmt -recursive -diff > fmt.out 2>&1
if [[ -s fmt.out ]]
then
  echo "Terraform fmt failed"
  cat fmt.out
  rm fmt.out
  exit 1
else
  rm fmt.out
fi
