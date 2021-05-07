# Summary: A module consumer

# Documentation: https://www.terraform.io/docs/language/settings/index.html
terraform {
  required_version = ">= 0.14.0"
}

# Documentation: https://www.terraform.io/docs/language/modules/syntax.html
module "changeme_hello_consumer" {
  source = "../hello_module"
}
