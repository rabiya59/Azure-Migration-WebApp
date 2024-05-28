variable "app_service_plan_name" {
    type = string
}
variable "rg_name" {
    type = string
}
variable "location" {
    type = string
}
variable "os_type" {
    type = string
}
variable "app_service_plan_sku" {
    type = string
}
variable "tags" {
  type = map(string)
}