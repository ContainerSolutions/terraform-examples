terraform {
  required_version = ">= 0.14.0"
}

output consumer_filename {
    value = module.hello.filename
}

module "hello" {
    source = "../local_file"
}
