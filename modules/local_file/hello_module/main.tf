terraform {
  required_version = ">= 0.14.0"
}

resource "local_file" "hello_local_file" {
    content     = "Hello terraform local module!"
    filename    = "hello_local.txt"
}
