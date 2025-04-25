resource "random_string" "sufix" {
  length  = 4
  special = false
  upper   = false
  lower   = true
  numeric = false

}