#!/bin/bash

cd "${0%/*}" || exit 1

echo '================================================================================'
echo "In $(pwd), running $0"
echo '================================================================================'

GCP_PROJECT="$(gcloud config get-value project)"
GCP_VPCS="changeme_vpc_native_cluster_vpc changeme_vpc_native_cluster_subnet"

for vpc in $GCP_VPCS
do
  vpc_name="$(echo "${vpc}" | tr '_' '-')"
  if [[ $(gcloud compute networks list --filter='name~^'"${vpc_name}"'$' 2>&1 | grep -v ^NAME | grep -v ^Listed.0 | awk '{print $1}') != '' ]]
  then
    terraform import -var project_id="${GCP_PROJECT}" "google_compute_network.${vpc}" "${vpc_name}"
  fi
done
