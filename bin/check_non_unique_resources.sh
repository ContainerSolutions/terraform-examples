#!/bin/bash

# Checks that all resources in the codebase have 'changeme' in them, and are unique across all code.

set -o errexit
set -o nounset

cd "${0%/*}/.."

echo "Running $0 ..."

RESOURCE_NAMES="$(find . -print0 -name '*\.tf' | xargs -0 grep -rnwI ^resource | awk '{print $3}' | sort -u | sed 's/"\(.*\)"/\1/')"
FAILED=0

for resource_name in ${RESOURCE_NAMES}
do
  echo "Checking $resource_name ..."
  files="$(grep -rnwIl '^resource.*'"\"$resource_name\"" .)"
  file_count="$(echo "$files" | wc -l)"
  if [[ $file_count -gt 1 ]]
  then
    printf "\n================================================================================\n%s is non-uniquely mentioned in files:\n$files\n" "$resource_name"
    FAILED=1
  fi
  if [[ ! $resource_name =~ ^changeme_ ]]
  then
    printf "\n================================================================================\n%s is not named appropriately in:\n$files\n" "$resource_name"
    FAILED=1
  fi
done
if [[ $FAILED -eq 1 ]]
then
  exit 1
fi
