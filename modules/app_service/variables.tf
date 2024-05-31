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
variable "app_logs_container" {
  type = string
}
variable "app_logs_retention" {
  type = string
}
variable "app_error_level" {
  type = string
}
variable "sql_server"{
  type = string
  sensitive = true
}
variable "sql_db_name"{
  type = string
  sensitive = true
}
variable "db_user_name"{
  type = string
  sensitive = true
}
variable "db_password"{
  type = string
  sensitive = true
}