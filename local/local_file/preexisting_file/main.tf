terraform {
  required_version = ">= 0.14.0"
}

data "local_file" "local_file_preexisting_file" {
  filename = "${path.module}/preexisting_file.txt"
}

output "preexisting_file_content" {
  value = data.local_file.local_file_preexisting_file.content
}
