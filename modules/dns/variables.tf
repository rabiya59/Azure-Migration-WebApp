variable "private_dns_zone_name" {
    type = string
}
variable "rg_name" {
    type = string
}
variable "vnet_id" {
    type = string
}
variable "nlink_name" {
    type = string
}
variable "tags" {
  type = map(string)
}