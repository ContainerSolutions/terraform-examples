#!/bin/bash
set -o errexit
set -o pipefail


if [ -z "$KUBE_CONFIG_PATH" ]
then
  KUBE_CONFIG_PATH="${HOME}/.kube/config"
  echo "By default we look for kube config file in ${KUBE_CONFIG_PATH}"
  echo "To use a custom kube config path, run 'export KUBE_CONFIG_PATH=<YOUR_KUBE_CONFIG_PATH>'"
fi
if [ -z "$KUBE_CTX" ]
then
  KUBE_CTX="$(kubectl config current-context)"
  echo "By default we use context: ${KUBE_CTX}"
  echo "To use a custom context, run 'export KUBE_CTX=<YOUR_KUBE_CTX>'"
fi

set -o nounset

export KUBE_CONFIG_PATH
export KUBE_CTX
