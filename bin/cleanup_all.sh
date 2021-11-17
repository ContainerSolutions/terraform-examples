#!/bin/bash

# Cleanup all examples:
# - It does two things:
#   1) Destroys all examples (bin/destroy_all.sh)
#   2) Removes all state files and .terraform dirs
# - If run without arguments, will destroy all examples from this repo
# - If run with a PATH, will destroy examples from a given dir (recursively)

set -o errexit
set -o pipefail

pushd "${0%/*}/.."
./bin/destroy_all.sh "$1"
popd

if [ -z "$1" ]
then
    pushd "${0%/*}/.."
else
    pushd "$1"
fi

set -o nounset

for d in $(find . | grep terraform.tfstate$ | xargs -n1 dirname)
do
    pushd "${d}"
    rm -rf .terraform* terraform.tfstate*
    popd
done

popd
