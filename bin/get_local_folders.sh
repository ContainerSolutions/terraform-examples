#!/bin/bash
# shellcheck disable=SC2034
LOCAL_FOLDERS="$(find local | grep tf$ | xargs -n1 dirname | sed 's/^.\///')"
