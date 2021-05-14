#!/bin/bash

set -o errexit
set -o pipefail

if [ -z "$GOOGLE_APPLICATION_CREDENTIALS" ]
then
  echo "If you want to suppress this input, run 'export GOOGLE_APPLICATION_CREDENTIALS=<YOUR_GOOGLE_APPLICATION_CREDENTIALS_PATH>'"
  echo 'To get this credentials path you can:'
  echo " a) Use your user account, by running: 'gcloud auth application-default login'"
  echo ' b) Use a service account, as documented here: https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/getting_started#adding-credentials'
  echo 'Input GOOGLE_APPLICATION_CREDENTIALS'
  read -r GOOGLE_APPLICATION_CREDENTIALS
fi
if [ -z "$TF_VAR_project_id" ]
then
  echo "If you want to suppress this input, run 'export TF_VAR_project_id=<YOUR_GCP_PROJECT_ID>'"
  echo "To find your current Project ID, run 'gcloud config get-value project'"
  echo 'Input TF_VAR_project_id'
  read -r TF_VAR_project_id
fi

set -o nounset

export GOOGLE_APPLICATION_CREDENTIALS
export TF_VAR_project_id
