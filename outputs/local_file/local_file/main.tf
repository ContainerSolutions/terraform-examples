# Summary: Example of output of local_file filename

# Documentation: https://www.terraform.io/docs/language/settings/index.html
terraform {
  required_version = ">= 1.0.0"
}

# Documentation:
variable "changeme_filename" {
  default = "changeme_default_filename.txt"
}

# Documentation: https://www.terraform.io/docs/language/values/variables.html
variable "changeme_content" {
  default = "Hello terraform local output module!"
}

# Documentation: https://www.terraform.io/docs/language/values/outputs.html
output "changeme_filename" {
  value = var.changeme_filename
}

# Documentation: https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file
resource "local_file" "changeme_local_file_hello_local_output" {
  content  = var.changeme_content
  filename = var.changeme_filename
}
