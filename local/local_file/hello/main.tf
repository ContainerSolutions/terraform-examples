# Summary: Create and manage a local file.

# Documentation: https://www.terraform.io/docs/language/settings/index.html
terraform {
  required_version = ">= 1.0.0"
}

# Documentation: https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file
resource "local_file" "changeme_local_file_hello" {
  content  = "Hello terraform local!"
  filename = "${path.module}/changeme_local_file_hello_${terraform.workspace}.txt"
}
