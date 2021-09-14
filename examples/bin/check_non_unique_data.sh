#!/bin/bash

set -o errexit
set -o nounset

cd "${0%/*}/.."

echo "Running $0 ..."

DATA_NAMES="$(find . -print0 -name '*\.tf' | xargs -0 grep -rnwI ^data | awk '{print $3}' | sort -u | sed 's/"\(.*\)"/\1/')"
FAILED=0

for data_name in ${DATA_NAMES}
do
  echo "Checking $data_name ..."
  files="$(grep -rnwIl '^data.*'"\"$data_name\"" .)"
  file_count="$(echo "$files" | wc -l)"
  if [[ $file_count -gt 1 ]]
  then
    printf "\n================================================================================\n%s is non-uniquely mentioned in files:\n$files\n" "$data_name"
    FAILED=1
  fi
  if [[ ! $data_name =~ ^changeme_ ]]
  then
    printf "\n================================================================================\n%s is not named appropriately in:\n$files\n" "$data_name"
    FAILED=1
  fi
done
if [[ $FAILED -eq 1 ]]
then
  exit 1
fi
