#!/bin/bash
# shellcheck disable=SC2034
OCI_FOLDERS="$(find oci | grep tf$ | xargs -n1 dirname | sed 's/^.\///')"
