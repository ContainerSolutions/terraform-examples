# Review Process

Steps needed:
1. Review the changes
    - Check with [Principles](https://github.com/ContainerSolutions/terraform-examples/blob/main/README.md#principles)
    - Check with [Conventions](https://github.com/ContainerSolutions/terraform-examples/blob/main/README.md#conventions)
2. Merge to integration (manually using git cli)
3. Wait for CI tests to finish
4. If CI is successful, then merge to `main` (using Github)

To merge with `main` branch, please follow these steps:

1. Export name of the branch as a variable:

    <pre>
    export BRANCH_TO_BE_TESTED="<name_of_the_branch>"
    </pre>

2. Reset --hard `integration` branch to `main`

    <pre>
    git checkout integration
    git reset --hard origin/main
    git push --force origin integration
    </pre>

3. Rebase the branch on top of 'main'

    <pre>
    git checkout "${BRANCH_TO_BE_TESTED}"
    git pull
    git rebase main
    # Fix conflicts if needed
    git rebase --continue
    git push --force origin "${BRANCH_TO_BE_TESTED}"
    </pre>

4. Merge the branch to 'integration'

    <pre>
    git checkout integration
    git pull origin integration
    git merge "origin/${BRANCH_TO_BE_TESTED}"
    git push origin integration
    </pre>

5. Check the CI test results on the integration branch
    - https://github.com/ContainerSolutions/terraform-examples/tree/integration

    - https://github.com/ContainerSolutions/terraform-examples/actions

    List of running tests can be found [here](https://github.com/ContainerSolutions/terraform-examples/blob/main/README.md#github-actions-workflow).

6. Accept the merge request (to main)

    - Use Squash and merge
    - Delete branch

7. Wait for the CI test to complete on the main branch
    - https://github.com/ContainerSolutions/terraform-examples/tree/main

8. Reset --hard `integration` branch to `main`

    <pre>
    git checkout integration
    git reset --hard origin/main
    git push --force origin integration
    </pre>