# Creates a local file with some content.

terraform {
  required_version = ">= 0.14.0"
}

variable filename {
  default = "default_filename.txt"
}

resource "local_file" "local_file_hello_local_variable" {
  content     = "Hello terraform local variable module!"
  filename    = var.filename
}
