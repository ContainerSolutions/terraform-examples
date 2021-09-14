#!/bin/bash

set -o errexit
set -o pipefail

if [ -z "$TF_VAR_azure_subscription_id" ]
then
  echo "If you want to suppress this input, run 'export TF_VAR_azure_subscription_id=<YOUR_AZURE_SUBSCRIPTION_ID>'"
  echo "To find your current Subscription ID, you need to:"
  echo " 1) Log in to Azure with: 'az login'"
  echo " 2) Run: 'az account show --query id --output tsv'"
  echo -n 'Input TF_VAR_azure_subscription_id: '
  read -r TF_VAR_azure_subscription_id
fi

set -o nounset

export TF_VAR_azure_subscription_id
