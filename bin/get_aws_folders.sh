#!/bin/bash
# shellcheck disable=SC2034
AWS_FOLDERS="$(find aws | grep tf$ | xargs -n1 dirname | sed 's/^.\///')"
