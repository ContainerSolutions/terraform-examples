#!/bin/bash

set -o errexit
set -o nounset

# find * -name main.tf | sort | xargs head -n1

# find . -maxdepth 1 -type d

PROVIDER_LIST=$(find . -maxdepth 1 -mindepth 1 -type d -not -path './\.*' -not -path './bin' | sed 's/\.\///g' | sort)

for provider in $PROVIDER_LIST; do
    echo $provider
    examples=$(find $provider -name main.tf)
    for example in $examples; do
        echo $example
        resource=$(echo $example | cut -d '/' -f 2)
        feature=$(echo $example | cut -d '/' -f 3)
        summary=$(head -n1 $example | sed 's/^# Summary: //g')
        echo "resource: $resource, feature: $feature, summary: $summary"
    done
    echo
done
# # Index of features

# ## AWS Examples
# | Resource                               | Feature  | Summary | 
# | -------------                          |:-------------:|:-------------:|
# | [aws_docdb_cluster](aws/aws_docdb_cluster)                   | [simple](aws/aws_docdb_cluster/simple) | |
# | [aws_db_instance](aws/aws_db_instance)                     | [simple](aws/aws_db_instance/simple) | summary... |
# | [aws_db_instance](aws/aws_db_instance)                     | [postgres](aws/aws_db_instance/postgres) | summary... |
# | [aws_db_instance](aws/aws_db_instance)                     | [restore_db_from_snapshot](aws/aws_db_instance/restore_db_from_snapshot) | summary... |
# | [aws_db_instance](aws/aws_db_instance)                     | [db_snapshot](aws/aws_db_instance/db_snapshot) | summary... |

