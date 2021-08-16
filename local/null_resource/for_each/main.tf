# Summary: Local null resource that iterates over a map using for_each

# Documentation: https://www.terraform.io/docs/language/settings/index.html
terraform {
  required_version = ">= 1.0.0"
}


# Documentation: https://www.terraform.io/docs/language/values/locals.html
locals {
  # Documentation: https://www.terraform.io/docs/language/expressions/types.html#maps-objects
  map1 = {
    item1 = {
      name1 = "item1value1"
      name2 = "item1value2"
    }
    item2 = {
      name1 = "item2value1"
      name2 = "item2value2"
    }
  }
}

# Documentation: https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource
resource "null_resource" "changeme_null_resource_foreach" {
  # Documentation: https://www.terraform.io/docs/language/meta-arguments/for_each.html
  for_each = local.map1
  # Documentation: https://www.terraform.io/docs/language/resources/provisioners/local-exec.html
  provisioner "local-exec" {
    command = "echo ${each.key} ${each.value.name1} ${each.value.name2}"
  }
}
