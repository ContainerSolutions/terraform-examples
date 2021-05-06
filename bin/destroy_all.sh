#!/bin/bash

cd "${0%/*}"/.. || exit 1

for d in $(find . | grep state$ | xargs -n1 dirname)
do
    cd "${d}" >/dev/null || exit 1
    if [[ $(terraform show -no-color) != "" ]]
    then
        echo "In folder: ${d}"
        terraform destroy
    fi
    cd - >/dev/null || exit 1
done
