variable filename {
  default = "default_filename.txt"
}
resource "local_file" "local_file_hello_local_variable" {
  content     = "Hello terraform local variable module!"
  filename    = var.filename
}
