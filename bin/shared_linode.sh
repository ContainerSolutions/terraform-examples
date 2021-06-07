#!/bin/bash

set -o errexit
set -o pipefail

if [ -z "$LINODE_TOKEN" ]
then
  echo "If you want to suppress this input, run 'export LINODE_TOKEN=<YOUR_LINODE_TOKEN>' on the command line"
  echo 'Input LINODE_TOKEN'
  read -r LINODE_TOKEN
fi

set -o nounset

export LINODE_TOKEN
