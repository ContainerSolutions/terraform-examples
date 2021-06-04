#!/bin/bash
# shellcheck disable=SC2034
LINODE_FOLDERS="$(find digitalocean | grep tf$ | xargs -n1 dirname | sed 's/^.\///')"
