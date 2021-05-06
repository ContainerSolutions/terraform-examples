#!/bin/bash

set -o errexit
set -o nounset

cd "${0%/*}/.."

if [[ $(terraform fmt -recursive -diff) != '' ]]
then
    echo "Terraform fmt failed"
    exit 1
fi
