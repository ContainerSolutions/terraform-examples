#!/bin/bash
VPC_IDS=$(aws ec2 describe-vpcs | jq -r '.Vpcs[] | select(.Tags and .Tags[].Key=="cs_terraform_examples" and .Tags[].Value=="aws_vpc/count") | .VpcId')
count=0
for vpc_id in $VPC_IDS
do
  terraform import "aws_vpc.aws_vpc_count[${count}]" "$vpc_id"
  ((count++))
done
