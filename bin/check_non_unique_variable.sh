#!/bin/bash

set -o errexit
set -o nounset

cd "${0%/*}/.."

echo "Running $0 ..."

IGNORE_VARIABLE_NAMES='project_id|azure_subscription_id' # variable names list separated with '|'
VARIABLE_NAMES="$(find . -print0 -name '*\.tf' | xargs -0 grep -rnwI ^variable | awk "!/${IGNORE_VARIABLE_NAMES}"'/{print $2}' | sort -u | sed 's/"\(.*\)"/\1/')"
FAILED=0

for variable_name in ${VARIABLE_NAMES}
do
  echo "Checking $variable_name ..."
  files="$(grep -rnwIl '^variable.*'"\"$variable_name\"" .)"
  file_count="$(echo "$files" | wc -l)"
  if [[ $file_count -gt 1 ]]
  then
    printf "\n================================================================================\n%s is non-uniquely mentioned in files:\n$files\n" "$variable_name"
    FAILED=1
  fi
  if [[ ! $variable_name =~ ^changeme_.* ]]
  then
    printf "\n================================================================================\n%s is not named appropriately in:\n$files\n" "$variable_name"
    FAILED=1
  fi
done
if [[ $FAILED -eq 1 ]]
then
  exit 1
fi
