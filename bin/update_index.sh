#!/bin/bash

set -o errexit
set -o nounset

TMP_INDEX_FILE=INDEX_TMP.md
INDEX_FILE=INDEX.md

touch $TMP_INDEX_FILE
echo '# Index of features' > $TMP_INDEX_FILE

PROVIDER_LIST=$(find . -maxdepth 1 -mindepth 1 -type d -not -path './\.*' -not -path './bin' | sed 's/\.\///g' | sort)

for provider in $PROVIDER_LIST; do
    provider_uppercase=$(echo "$provider" | awk '{print toupper($0)}')
    provider_lowercase=$(echo "$provider" | awk '{print tolower($0)}')
    {
        echo -e "## ${provider_uppercase} Examples"
        echo '| Resource      | Feature       | Summary       |'
        echo '| ------------- |:-------------:|:-------------|'
    } >> $TMP_INDEX_FILE
    examples=$(find "$provider" -name main.tf)

    for example in $examples; do
        resource=$(echo "$example" | cut -d '/' -f 2)
        feature=$(echo "$example" | cut -d '/' -f 3)
        summary=$(head -n1 "$example" | sed 's/^# Summary: //g')
        # echo "resource: $resource, feature: $feature, summary: $summary"
        echo "| [${resource}](${provider_lowercase}/${resource}) | [${feature}](${provider_lowercase}/${resource}/${feature}) | ${summary} |" >> $TMP_INDEX_FILE
    done

done

mv $TMP_INDEX_FILE $INDEX_FILE