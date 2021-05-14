#!/bin/bash

set -o errexit
set -o nounset

cd "${0%/*}"

FILES="$(find .. -type f ! -path "../.git*")"

for file in $FILES
do
  if file -b "$file" | grep shell.script >/dev/null
  then
    echo "Checking file: ${file}"
    shellcheck -x "$file"
  fi
done
shellcheck -x -- *sh
