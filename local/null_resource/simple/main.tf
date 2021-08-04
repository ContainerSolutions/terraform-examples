# Summary: Simple example of local null_resource that runs a command

# Documentation: https://www.terraform.io/docs/language/settings/index.html
terraform {
  required_version = ">= 1.0.0"
}

# Documentation: https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource
resource "null_resource" "changeme_null_resource_simple" {
  provisioner "local-exec" {
    command = "echo Hello World"
  }
}
