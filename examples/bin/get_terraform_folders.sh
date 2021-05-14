#!/bin/bash
# shellcheck disable=SC2034
TERRAFORM_FOLDERS="$(find . | grep tf$ | xargs -n1 dirname | sed 's/^.\///')"
