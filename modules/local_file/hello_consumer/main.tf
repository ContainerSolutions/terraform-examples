terraform {
  required_version = ">= 0.14.0"
}

module "hello_consumer" {
    source = "../hello_module"
}
