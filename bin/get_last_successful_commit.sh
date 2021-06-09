#!/bin/bash

set -o errexit
set -o nounset

cd "${0%/*}"/..

tail -1 .test_log.log
