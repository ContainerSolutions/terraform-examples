#!/bin/bash

# Run all examples:
# - If run without arguments, will apply all examples from this repo
# - If run with a PATH, will apply examples from a given dir (recursively)

set -o errexit
set -o pipefail

if [ -z "$1" ]
then
    cd "${0%/*}"/..
else
    cd "$1"
fi

set -o nounset

for d in $(find . | grep state$ | xargs -n1 dirname)
do
    cd "${d}" >/dev/null
    echo "$0 in folder: ${d}"
    ./run.sh
    cd - >/dev/null
done
