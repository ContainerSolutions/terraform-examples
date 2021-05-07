This example sets up a S3 backend with a minimal example of a state stored in it.

It:

- Creates an S3 bucket with a random name ('te-xxxxxxxxxxxxx')

- Sets up an AWS VPC, storing state in that backend

These are the files used:

`destroy.sh`              - Shell script to clean up any previous run of `run.sh`

`run.sh`                  - Run this whole example up, creating the Bucket, backend, and AWS VPC

`aws_s3_bucket/main.tf`   - Terraform code to set up a bucket

`aws_s3_bucket/run.sh`    - Script to create just the bucket

`aws_s3_bucket/destroy.sh` - Script to destroy just the bucket

`aws_vpc/main_template`    - Template file for Terraform code for AWS VPC

