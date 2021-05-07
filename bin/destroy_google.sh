#!/bin/bash

cd "${0%/*}" || exit 1
source ./shared_google.sh
cd -

terraform init
terraform plan
terraform destroy
