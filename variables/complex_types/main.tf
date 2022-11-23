variable "structural-type" {
  type = object({
    object = object({
      string = string
      number = number
      bool   = bool
    }),
    list = list(any),
    map  = map(string),
    set  = set(number)
  })
}

output "structural-type" {
  value = var.structural-type
}
