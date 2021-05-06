terraform {
  required_version = ">= 0.14.0"
}

resource "local_file" "local_file_hello" {
  content  = "Hello terraform local!"
  filename = "${path.module}/local_file_hello_${terraform.workspace}.txt"
}
