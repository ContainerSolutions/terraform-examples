#!/bin/bash

set -o errexit
set -o pipefail

if [ -z "$AWS_ACCESS_KEY_ID" ]
then
  echo "If you want to suppress this input, run 'export AWS_ACCESS_KEY_ID=<YOUR_AWS_ACCCESS_KEY_ID>' on the command line"
  echo 'Input AWS_ACCESS_KEY_ID'
  read -r AWS_ACCESS_KEY_ID
fi

if [ -z "$AWS_SECRET_ACCESS_KEY" ]
then
  echo "If you want to suppress this input, run 'export AWS_SECRET_ACCESS_KEY=<YOUR_AWS_SECRET_ACCCESS_KEY>' on the command line"
  echo 'Input AWS_SECRET_ACCESS_KEY'
  read -r -s AWS_SECRET_ACCESS_KEY
fi

set -o nounset

export AWS_ACCESS_KEY_ID
export AWS_SECRET_ACCESS_KEY
