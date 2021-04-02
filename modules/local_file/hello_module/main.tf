resource "local_file" "hello_local_file" {
    content     = "Hello terraform local module!"
    filename    = "hello_local.txt"
}
