#!/bin/bash

set -o errexit
set -o nounset

cd "${0%/*}/.."

echo "$GCP_CREDENTIALS_FILE" > "$GCP_CREDENTIALS_FILENAME"
cat "$GCP_CREDENTIALS_FILENAME"

# shellcheck disable=SC1091
source bin/get_gcp_folders.sh
for folder in ${GCP_FOLDERS}
do
  echo "================================================================================"
  echo -n "Checking folder: ${folder} ... "
  pushd "${folder}" >/dev/null
  echo -n "./run.sh"
  ./run.sh
  echo -n "./destroy.sh"
  ./destroy.sh
  popd >/dev/null
done
