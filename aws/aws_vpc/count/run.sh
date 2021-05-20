#!/bin/bash
cd "${0%/*}" || exit 1
../../../bin/apply_aws.sh || ./cleanup.sh
../../../bin/apply_aws.sh
cd - || exit 1
