# Table of Contents <!-- omit in toc -->
- [Contributing](#contributing)
  - [Principles](#principles)
  - [Conventions](#conventions)
  - [Issues](#issues)
    - [Create a new issue](#create-a-new-issue)
    - [Solve an issue](#solve-an-issue)
  - [Milestones](#milestones)
  - [Development](#development)
    - [Local Development](#local-development)
      - [Folder for new examples:](#folder-for-new-examples)
    - [Local Testing](#local-testing)
    - [Commit Changes and Push](#commit-changes-and-push)
    - [CI Checks on Local Branch](#ci-checks-on-local-branch)
    - [Pull Request](#pull-request)
    - [Pull Request Review](#pull-request-review)
    - [CI Checks on main and integration Branches](#ci-checks-on-main-and-integration-branches)
      - [Forcing tests](#forcing-tests)
    - [PR Merged](#pr-merged)
    - [Updating Web UI](#updating-web-ui)

# Contributing

New contributors to the project can get an overview of the project by reading the [README](README.md) and checking examples in the repository.

This document is aimed to explain contribution process to terraform-examples repository. Please note that contributions to the project should align with [Principles](#principles) and [Conventions](#conventions).

## Principles

The examples seek to be:

- As simple as possible to illustrate the functionality

- Self-contained (ie limited to one `.tf` file)

- Clear (eg resource names are verbose and unambiguous)

## Conventions

- Naming examples:
  - `simple` - for minimal functionality demonstration
  - `<functionality>` - when demonstrating something more than minimal
  - directory structure: `<provider>/<resource_type>/<example_name>`

- Where it makes sense, items that can be changed are prefaced with `changeme_`

- In general, underscores are used in Terraform names over dashes

- Naming Terraform resources, data, and variables:
  - use only lower case letters, numbers, and underscore
  - names should be unique between all examples (but across resources items only if a resource; data items only if data, etc)
  - prefixed with:  `changeme_<example_name>_`

- `name =` attribute within the resource:
  - use only lower case letters, numbers, and dash
  - same as resource name, but with: `s/_/-/g`

- For help with automated testing
  - where possible, add some way to enable 'left-over' resources to be cleaned up, eg provider `default_tags` of `cs_terraform_examples` in AWS provider blocks

- Add inline documentation for each Terraform code block
  - `# Summary:` – 1-line summary of what this example does
  - `# Documentation:` – add link to documentation before each block (terraform, provider, variable, resource, etc.)
  - `# Explanation:` – add only where some extra explanation is needed

## Issues

### Create a new issue

If you spot a problem with terraform scripts, CI checks, bash scripts, documents, etc. you can [search for related issues](https://github.com/ContainerSolutions/terraform-examples/issues) and if there aren't any related issues, then you can open a [new issue](https://github.com/ContainerSolutions/terraform-examples/issues/new/choose).

### Solve an issue

You can search for [existing issues](https://github.com/ContainerSolutions/terraform-examples/issues), and if you intend to solve one of them, then you can make changes for it in a new branch and create a Pull Request for the fix.

## Milestones

We are tracking [milestones on GitHub](https://github.com/ContainerSolutions/terraform-examples/milestones) and using [GitHub projects](https://github.com/ContainerSolutions/terraform-examples/projects) to keep track of them. Similar to solving issues, if you intend to work on one of the items there, then you can make changes for it in a new branch and create a Pull Request for it.


## Development

Changes should be made on different branches and then merged with main and integration branches according to procedures explained below.

### Local Development

1. Terraform (with version >= 1.0.0) should be installed and it should be added to the path. To download terraform binary, check [this link](https://www.terraform.io/downloads).
2. On Windows systems, bash should be installed and sh scripts should be invoked from bash shell. To install git bash, check [this link](https://git-scm.com/downloads).
3. An IDE with linting installed for Terraform can be used optionally (e.g. VS Code and [HashiCorp Terraform Extension](https://marketplace.visualstudio.com/items?itemName=HashiCorp.terraform))
4. This repository should be forked (for contributors outside of CS organization). You can check official GitHub documentations for [Forking a repo](https://docs.github.com/en/get-started/quickstart/fork-a-repo) and [Syncing a fork](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/working-with-forks/syncing-a-fork).
5. New branch should be created for development or fix
6. Formatting for newly added or changed Terraform scripts should be corrected with `terraform fmt`
7. Changes can be tested locally before committing to the repository according to explanation [below](#local-testing).

#### Folder for new examples:

New Terraform example should be created in a folder based on its provider and resource name of the example, e.g. to provision AWS EC2 instance, aws provider's aws_instance resource is used, hence examples related to AWS EC2 instances are in `aws/aws_instance` path. Under this path, simple examples should be in a folder named `simple`, whereas other examples showing different usages of the same resource type can be in folders named according to the example.

Inside the determined folder, there should be following files:
- run.sh: sh script which invokes [bin/apply.sh](bin/apply.sh) with provider as argument. This script should be executable.
- destroy.sh: sh script which invokes [bin/destroy.sh](bin/destroy.sh) with provider as argument. This script should be executable.
- main.tf: Terraform script for the example

### Local Testing

You can test your changes before committing to the repository by executing `run.sh` script in the directory. Credentials required for the provider may be prompted. `run.sh` will execute [bin/apply.sh](bin/apply.sh), which executes terraform init, plan and apply.

You can destroy the resources provisioned with destroy.sh, which will execute [bin/destroy.sh](bin/destroy.sh), which executes terraform init, plan and destroy.

To prevent unnecessary charges, please don't forget to destroy resources after your tests are complete!

### Commit Changes and Push

Commit your changes with meaningful commit message when you have completed development.

### CI Checks on Local Branch

On every commit, the following tests run on all branches:

- A `tflint` on all files ending with `tf`

- A `terraform validate` on all

- A series of checks to test the code against standards

### Pull Request

- Create Pull Request when you are ready to merge your changes
- Fill the Pull Request template by linking related issues, adding information about changed/added features 
- Submit the Pull Request
- Wait for CI checks to complete
- Update items in the checklist
- Request PR review from reviewers.

### Pull Request Review

Reviewers will validate your commit and merge your changes to main and integration branches.

### CI Checks on main and integration Branches

On every commit to the `integration` and `main branches`:

- A `tflint` on all files ending with `tf`

- A `terraform validate` on all

- A series of checks to test the code against standards

- All AWS provider examples are run against an AWS account

- All GCP provider examples are run against a GCP account

- All Linode provider examples are run against a Linode account

- All DigitalOcean provider examples are run against a DigitalOcean account

- All 'local' provider examples are run locally on the GitHub Actions runner

#### Forcing tests

You can force a test for a given provider (on the `integration` or `main` branches only) by adding a `.forcetest` file to the relevant folder.

For example, if you want to ensure that the aws tests run, then add an empty file in `aws/.forcetest`. On a successfully completed test run, these files are removed as part of the 'success commit' in the github action workflow.

### PR Merged

Your PR is now merged, thank you for your contribution to terraform-examples. If you updated terraform scripts, then it may be better to update the Web UI as well. Please follow procedures in the next section to update Web UI.

### Updating Web UI
As it can be seen in [README](README.md#terraform-examples), searchable web UI of the project is at [this link](https://containersolutions.github.io/terraform-examples/). To update Web UI you can follow these steps:

1. Update example files by running following commands on the shell:
    <pre>
    # please run these commands at the root directory of the repository
    git switch main
    
    # temporary directory will be created for copying files from main to terraform-examples-UI branch
    mkdir ../terraform-examples-main-temp
    
    # copying to temp directory
    find . -maxdepth 1 -mindepth 1 -type d -not -path './\.*' -exec cp -r {} ../terraform-examples-main-temp \;
    
    # switch to terraform-examples-UI branch
    git switch terraform-examples-UI
    
    # create a branch for updates
    BRANCH_NAME=terraform-examples-UI-update-$(date +'%m%d%y')
    git checkout -b ${BRANCH_NAME}
    
    # dry run for rsync:
    rsync -avn --include='*/' --include='*.tf' --include='*.sh' --exclude='*' ../terraform-examples-main-temp/ examples/
    
    # actual run of rsync:
    rsync -av --include='*/' --include='*.tf' --include='*.sh' --exclude='*' ../terraform-examples-main-temp/ examples/
    
    # removing temporary directory
    rm -rf ../terraform-examples-main-temp
    </pre>
2. Check missing index files for any of the provider directories and add missing index files if it's needed.
    <pre>
    ./release.sh
    </pre>

3. Test updated web UI locally

    You should have ruby installed to test web UI. If you haven't run this project locally before, you should install ruby and gems first.

    Install ruby: https://www.ruby-lang.org/en/downloads/

    Install gems while you are on terraform-examples-UI branch:
    <pre>
    gem install bundler
    bundle install
    </pre>

    After installation, you can run jekyll locally while you are on terraform-examples-UI branch:
    <pre>
    bundle exec jekyll serve
    </pre>
4. Commit changes on the new branch and push
5. Create a Pull Request to merge updated terraform-examples-UI-update-... branch to terraform-examples-UI branch.
6. Check CI run for the Pull Request terraform-examples-UI branch
7. Request a review for the proposed updates
8. After the PR is merged, confirm updates on the live page
