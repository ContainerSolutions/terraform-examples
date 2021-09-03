# Summary: Creates a local file with some content.

# Documentation: https://www.terraform.io/docs/language/settings/index.html
terraform {
  required_version = ">= 1.0.0"
}

# Documentation: https://www.terraform.io/docs/language/values/variables.html
variable "changeme_variables_local_file_local_file_filename" {
  default = "changeme_default_filename.txt"
}

# Documentation: https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file
resource "local_file" "changeme_local_file_hello_local_variable" {
  content  = "Hello terraform local variable module!"
  filename = var.changeme_variables_local_file_local_file_filename
}
