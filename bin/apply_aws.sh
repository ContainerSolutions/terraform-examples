#!/bin/bash

cd "${0%/*}" || exit 1
source ./shared_aws.sh
cd -

terraform init
terraform plan
terraform apply
