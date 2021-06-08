#!/bin/bash
# shellcheck disable=SC2034
AZURERM_FOLDERS="$(find azurerm | grep tf$ | xargs -n1 dirname | sed 's/^.\///')"
