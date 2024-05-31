variable "my_sql_flx_server_name" {
    type = string
}                   
variable "rg_name" {
    type = string
}    
variable "location" {
    type = string
}
variable "adm_login" {
    type = string
}
variable "adm_passwd" {
    type = string
}
variable "sku_name" {
    type = string
}
variable "backup_retention_days" {
  type = number
}
variable "geo_redundant_backup_enabled" {
  type = string
}
variable "delegated_subnet_id" {
  type = string
}
variable "db_size" {
  type = string
}
variable "private_dns_zone_id" {
  type = string
}
variable "tags" {
  type = map(string)
}