# Summary: Take an existing file into a Terraform state, using data.local_file's configuration.

# Documentation: https://www.terraform.io/docs/language/settings/index.html
terraform {
  required_version = ">= 1.0.0"
}

# Documentation: https://registry.terraform.io/providers/hashicorp/local/latest/docs/data-sources/file
data "local_file" "changeme_local_file_preexisting_file" {
  filename = "${path.module}/changeme_preexisting_file.txt"
}

# Documentation: https://www.terraform.io/docs/language/values/outputs.html
output "changeme_preexisting_file_content" {
  value = data.local_file.changeme_local_file_preexisting_file.content
}
