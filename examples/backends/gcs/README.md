This example sets up a GCS backend with a minimal example of a state stored in it.

It:

- Creates an GCS bucket with a random name ('changeme-xxxxxxxxxxxxx')

- Sets up an GCP VPC, storing state in that backend

These are the files used:

`destroy.sh`                           - Shell script to clean up any previous run of `run.sh`

`run.sh`                               - Run this whole example up, creating the bucket, backend, and GCP VPC

`google_storage_bucket/main.tf`        - Terraform code to set up a bucket

`google_storage_bucket/run.sh`         - Script to create just the bucket

`google_storage_bucket/destroy.sh`     - Script to destroy just the bucket

`google_compute_network/main_template` - Template file for Terraform code for GCP VPC

