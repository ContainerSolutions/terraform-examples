terraform {
  required_version = ">= 0.14.0"
}

resource "null_resource" "null_resource_simple" {
    provisioner "local-exec" {
        command = "echo Hello World"
    }
}
