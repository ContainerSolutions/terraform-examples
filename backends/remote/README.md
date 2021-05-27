This example sets up a remote backend with a minimal example of a state stored in it.

It:

- Connects to Terraform Cloud organization "terraform-examples" and creates/updates workspace "backends/remote"

- Sets up an AWS VPC, storing state in that backend

These are the files used:

`destroy.sh` - Shell script to clean up any previous run of `run.sh`

`run.sh` - Run this whole example up, setting up backend, and AWS VPC

`main.tf` - Template file for Terraform code for AWS VPC using remote backend

There are mandatory manual steps to be done on Terraform Cloud:

1. Register an account
1. Create [organization](https://app.terraform.io/app/organizations/new)
1. Create workspace in that organization
1. Change "Execution Mode" (Settings->General) to "Local", this will make sure that Terraform Cloud is only used to store and synchronize state.
1. We will follow [CLI-driven Run Workflow](https://www.terraform.io/docs/cloud/run/cli.html). Ensure you are properly authenticated into Terraform Cloud by running `terraform login` or by use a [credentials](https://www.terraform.io/docs/cli/config/config-file.html#credentials) block.
1. After running run.sh, and approving the apply you should be able to see your state stored in the workspace under the `State` tabs.
