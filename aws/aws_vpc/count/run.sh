#!/bin/bash
cd "${0%/*}" || exit 1
if ! ../../../bin/apply_aws.sh
then
  ./cleanup.sh
  ../../../bin/apply_aws.sh
fi
cd - || exit 1
