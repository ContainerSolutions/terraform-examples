#!/bin/bash

set -o errexit
set -o pipefail

TERRAFORM_CLOUD_LOGIN_TOKEN_FILE="${HOME}/.terraform.d/credentials.tfrc.json"

if [[ "${CI_USE_TF_CLOUD:-false}" == 'true' ]]
then
  if [ ! -e "${TERRAFORM_CLOUD_LOGIN_TOKEN_FILE}" ] && [ -z "$TERRAFORM_CLOUD_LOGIN_TOKEN" ]
  then
    echo "If you want to suppress this input, run 'export TERRAFORM_CLOUD_LOGIN_TOKEN=<YOUR_TERRAFORM_LOGIN_TOKEN_FILE_CONTENTS>' on the command line or create a token file in ${HOME}/.terraform.d/credentials.tfrc.json or set CI_USE_TF_CLOUD to a value other than 'true'"
    echo 'Input TERRAFORM_CLOUD_LOGIN_TOKEN'
    read -r TERRAFORM_CLOUD_LOGIN_TOKEN
  fi
  mkdir -p "${HOME}/.terraform.d"
  echo "$TERRAFORM_CLOUD_LOGIN_TOKEN" > "${TERRAFORM_CLOUD_LOGIN_TOKEN_FILE}"
fi

set -o nounset
