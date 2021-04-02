variable myfilename {
  default = "module_default_filename.txt"
}
module "hello" {
  source = "../local_file"
  filename = var.myfilename
}
