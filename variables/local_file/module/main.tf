# This example uses the `../local_file` module to give an example
# using modules.

terraform {
  required_version = ">= 0.14.0"
}

variable "myfilename" {
  default = "module_default_filename.txt"
}

module "hello" {
  source   = "../local_file"
  filename = var.myfilename
}
