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

# If someone requires a token for the deployment then please uncomment the following code [`IF block` requesting session token]
# and export AWS_SESSION_TOKEN

# if [ -z "$AWS_SESSION_TOKEN" ]
# then
#   echo "If you want to suppress this input, run 'export AWS_SESSION_TOKEN=<YOUR_AWS_SESSION_TOKEN>' on the command line"
#   echo 'Input AWS_SESSION_TOKEN'
#   read -r -s AWS_SESSION_TOKEN
# fi

set -o nounset

export AWS_ACCESS_KEY_ID
export AWS_SECRET_ACCESS_KEY
# export AWS_SESSION_TOKEN
