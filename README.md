# terraform-examples

A reference repository of Terraform with canonical and as-simple-as-possible demonstrations of Terraform functionality and features.

See [here](https://containersolutions.github.io/terraform-examples/) for docs.

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

- Where it makes sense, items that can be changed are prefaced with `changeme_`

- In general, underscores are used in Terraform names over dashes

- Naming Terraform resources:
  - use only lower case letters, numbers, and underscore
  - names should be unique between all examples
  - prefixed with:  `changeme_<example_name>_`

- `name =` attribute within the resource:
  - use only lower case letters, numbers, and dash
  - same as resource name, but with: `s/_/-/g`

- For help with automated testing
  - where possible, add some way to enable 'left-over' resources to be cleaned up, eg provider `default_tags` of `cs_terraform_examples` in AWS provider blocks

## Sources / Thanks To

[Learn Terraform The Hard Way](https://leanpub.com/learnterraformthehardway)
