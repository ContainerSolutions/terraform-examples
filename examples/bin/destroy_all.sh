#!/bin/bash

# Destroy all examples:
# - If run without arguments, will destroy all examples from this repo
# - If run with a PATH, will destroy examples from a given dir (recursively)

set -o errexit
set -o pipefail

if [ -z "$1" ]
then
    cd "${0%/*}"/..
else
    cd "$1"
fi

set -o nounset

failed=""
for d in $(find . | grep state$ | xargs -n1 dirname)
do
    cd "${d}" >/dev/null
    if [[ $(terraform show -no-color) != "" ]]
    then
        echo "In folder: ${d}"
        ./destroy.sh || failed+="${d}"$'\n'
    fi
    cd - >/dev/null
done

if [[ "${failed}" != "" ]]
then
  echo "Failed to destroy:"
  echo -n "${failed}"
  exit 1
fi
