# Summary: Example of including a module and outputting a variable from it

# Documentation: https://www.terraform.io/docs/language/settings/index.html
terraform {
  required_version = ">= 1.0.0"
}

# Documentation: https://www.terraform.io/docs/language/values/outputs.html
output "changeme_consumer_filename" {
  value = module.changeme_hello.changeme_filename
}

# Documentation: https://www.terraform.io/docs/language/modules/syntax.html
module "changeme_hello" {
  source = "../local_file"
}
