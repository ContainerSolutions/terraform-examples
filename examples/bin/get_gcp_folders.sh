#!/bin/bash
# shellcheck disable=SC2034
GCP_FOLDERS="$(find google | grep tf$ | xargs -n1 dirname | sed 's/^.\///')"
