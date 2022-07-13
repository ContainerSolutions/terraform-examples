# terraform-examples

A reference repository of Terraform with canonical and as-simple-as-possible demonstrations of Terraform functionality and features.

See here for a searchable front-end: https://containersolutions.github.io/terraform-examples/

## Why?

At Container Solutions we find we regularly need chunks of Terraform to demonstrate something specific, such as:

- A simple EC2 instance

- A bespoke VPC

- A Windows EC2 instance with an EBS volume

This might be to do a basic test of something, find an example to tinker with, or send to someone to get them going.

## Usage

To help get started with these examples, there are scripts available in `bin` and in local folders.

Here's an example run:

```
$ git clone https://github.com/ContainerSolutions/terraform-examples
$ cd terraform-examples
$ cd aws/aws_vpc
$ ./run.sh
Input AWS_ACCESS_KEY_ID
KEY
Input AWS_SECRET_ACCESS_KEY
<secret>
...
```

If you want to skip the manual key/id inputs, then export them.

See `bin/README.md` for more information.

## Where is...?

If you want to look for a specific example, try the [index](INDEX.md).

## Sections

The code is generally divided up by provider, then resource, then whatever the example illustrates, eg `local/null_resource/for_each`, or `aws/aws_instance/remote-exec/inline`.

Other basic language features may be illustrated in their own folders, eg `outputs/local_file/module`.

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

## Contributing

Contributions to terraform-examples project are welcome. You can find detailed information about [contributing here](CONTRIBUTING.md).

## GitHub Actions Workflow

On every commit/push, the following tests run on all branches:

- A `tflint` on all files ending with `tf`

- A `terraform validate` on all

- A series of checks to test the code against standards


Using slash command /test, a maintainer can run Cloud Testing jobs. 
This includes:

- All AWS provider examples are run against an AWS account

- All GCP provider examples are run against a GCP account

- All Linode provider examples are run against a Linode account

- All DigitalOcean provider examples are run against a DigitalOcean account

- All 'local' provider examples are run locally on the GitHub Actions runner

Cloud Environment tests are long and/or cost money and they won't work without the necessary auth information being set up correctly. 

The auth information for the provider accounts are stored in secrets in the repository, accessible to the admin.


Slash commands can be used to approve/merge the PR, '/approve' or '/merge'.

The Flow:

- PR is opened

- Contributor commits/pushes on-demand and triggers the Statis Tests

- Once ready, and maintainer runs the Full-CI, which includes Cloud Tests '/test'

- If everything goes well, the maintainer uses the command '/approve' to mark as reviewed/approve

- The last step, after everything is checked, '/merge' to perform the merge to the main branch


Note: All the slash commands are performed by Github Actions BOT with GITHUB_TOKEN


### Forcing tests

You can force a test for a given provider (on `main` branch only) by adding a `.forcetest` file to the relevant folder.

For example, if you want to ensure that the aws tests run, then add an empty file in `aws/.forcetest`. On a successfully completed test run, these files are removed as part of the 'success commit' in the github action workflow.

## Maintainer Information

For information for maintainers of this repository at ContainerSolutions, see [maintainers](MAINTAINERS.md)

## Sources / Thanks To

[Learn Terraform The Hard Way](https://leanpub.com/learnterraformthehardway)
[Slash Commands](https://github.com/marketplace/actions/slash-commands)

## Other Examples

[Immutable Cluster Using Packer and Ansible on AWS](https://github.com/bluebrown/immutable-cluster)


