#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

echo 'Input AWS_ACCESS_KEY_ID'
read AWS_ACCESS_KEY_ID
echo 'Input AWS_SECRET_ACCESS_KEY'
read -s AWS_SECRET_ACCESS_KEY

export AWS_ACCESS_KEY_ID
export AWS_SECRET_ACCESS_KEY

terraform init
terraform plan
terraform apply
