variable "app_service_name" {
    type = string
}
variable "rg_name" {
    type = string
}
variable "location" {
    type = string
}
variable "service_plan_id" {
    type = string
}

variable "tags" {
  type = map(string)
}

# variable "application_stack" {
#   type = map(string)
# }

variable "php_version" {
  type = string
  description = "The PHP Version"
}
variable "vnet_name"{
  type = string
}
variable "subnet_id"{
  type = string
}
