#!/bin/bash
cd "${0%/*}" || exit 1
# If this is non-interactive, then cleanup on failure...
if [[ $- != *i* ]]
then
  ../../../bin/apply_aws.sh || ( ./import.sh && ./destroy.sh )
  ../../../bin/apply_aws.sh
else
  ../../../bin/apply_aws.sh
fi
cd - || exit 1
