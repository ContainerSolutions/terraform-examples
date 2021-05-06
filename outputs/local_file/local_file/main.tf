terraform {
  required_version = ">= 0.14.0"
}

variable "filename" {
  default = "default_filename.txt"
}

variable "content" {
  default = "Hello terraform local output module!"
}

output "filename" {
  value = var.filename
}

resource "local_file" "local_file_hello_local_output" {
  content  = var.content
  filename = var.filename
}
