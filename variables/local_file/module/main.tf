# Summary: This example uses the `../local_file` module to give an example using modules.

# Documentation: https://www.terraform.io/docs/language/settings/index.html
terraform {
  required_version = ">= 0.14.0"
}

# Documentation: https://www.terraform.io/docs/language/values/variables.html
variable "myfilename" {
  default = "changeme_module_default_filename.txt"
}

# Documentation: https://www.terraform.io/docs/language/modules/index.html
module "hello" {
  source   = "../local_file"
  filename = var.myfilename
}
