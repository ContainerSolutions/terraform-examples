#!/bin/bash

cd "${0%/*}" || exit 1

echo '================================================================================'
echo "In $(pwd), running $0"
echo '================================================================================'

INIT_DONE="N"
VPC_IDS=$(aws ec2 describe-vpcs | jq -r '.Vpcs[] | select(.Tags and .Tags[].Key=="cs_terraform_examples" and .Tags[].Value=="aws_vpc/for") | .VpcId')
count=0
for vpc_id in $VPC_IDS
do
  if [[ ${INIT_DONE} == "N" ]]
  then
    INIT_DONE="Y"
    terraform init
  fi
  terraform import "aws_vpc.changeme_aws_vpc_for[${count}]" "$vpc_id"
  ((count++))
done
