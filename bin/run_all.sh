#!/bin/bash

# Run all examples:
# - If run without arguments, will apply all examples from this repo
# - If run with a PATH, will apply examples from a given dir (recursively)

if [ ! -n "$1" ]
then
    cd "${0%/*}"/.. || exit 1
else
    cd "$1"
fi

for d in $(find . | grep state$ | xargs -n1 dirname)
do
    cd "${d}" >/dev/null || exit 1
    echo "In folder: ${d}"
    ./run.sh
    cd - >/dev/null || exit 1
done
