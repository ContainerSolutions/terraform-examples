#!/bin/bash

# Destroy all examples:
# - If run without arguments, will destroy all examples from this repo
# - If run with a PATH, will destroy examples from a given dir (recursively)

if [ ! -n "$1" ]
then
    cd "${0%/*}"/.. || exit 1
else
    cd "$1"
fi

for d in $(find . | grep state$ | xargs -n1 dirname)
do
    cd "${d}" >/dev/null || exit 1
    if [[ $(terraform show -no-color) != "" ]]
    then
        echo "In folder: ${d}"
        ./destroy.sh
    fi
    cd - >/dev/null || exit 1
done
