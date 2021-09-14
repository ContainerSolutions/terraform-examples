#!/bin/bash

# Outputs folders that have changed since the last confirmed successful commit on main

set -o errexit
set -o nounset

cd "${0%/*}"/..

files_changed=$(git diff --name-only "$(./bin/get_last_successful_commit.sh)" | grep '\.tf$' | sort -u)
folders=""

for filename in $files_changed
do
  folders="${folders} $(dirname "$filename")"
done

# Remove any dupes
folders=$(echo "$folders" | tr ' ' '\n' | sort | uniq | tr '\n' ' ' | sed -e 's/[[:space:]]*$//')

for f in $folders
do
  echo "$f"
done
