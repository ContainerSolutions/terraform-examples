#!/bin/bash
if ! find . -type d -depth 1 | grep -v examples | grep -vw _sass | egrep -vw '(_posts|_includes|\.gif|_sass|_layouts|\.github|\.git)' | xargs -IXXX ls examples/XXX/XXX.md >/dev/null
then
  echo "Add examples/FOLDER/FOLDER.md to the folder that's mentioned above"
  exit 1
fi
