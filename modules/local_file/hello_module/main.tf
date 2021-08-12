# Summary: A local_file example to be used as a module

# Documentation: https://www.terraform.io/docs/language/modules/index.html
terraform {
  required_version = ">= 1.0.0"
}

# Documentation: https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file
resource "local_file" "changeme_hello_local_file" {
  content  = "Hello terraform local module!"
  filename = "hello_local.txt"
}
