#!/bin/bash
# shellcheck disable=SC2034
LINODE_FOLDERS="$(find linode | grep tf$ | xargs -n1 dirname | sed 's/^.\///')"
