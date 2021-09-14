#!/bin/bash

set -o errexit
set -o pipefail

if [ -z "$DIGITALOCEAN_TOKEN" ]
then
  echo "If you want to suppress this input, run 'export DIGITALOCEAN_TOKEN=<YOUR_DIGITALOCEAN_TOKEN>' on the command line"
  echo 'Input DIGITALOCEAN_TOKEN'
  read -r DIGITALOCEAN_TOKEN
fi

set -o nounset

export DIGITALOCEAN_TOKEN
