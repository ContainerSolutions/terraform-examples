output consumer_filename {
    value = module.hello.filename
}
module "hello" {
    source = "../local_file"
}
