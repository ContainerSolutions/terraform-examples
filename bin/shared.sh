#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

function log {
  msg=$1
  echo '================================================================================'
  echo "$msg"
  echo '================================================================================'
}
