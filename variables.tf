variable "project_name" {
  type        = string
  default     = "ypsolapp"
  description = "The name of the project"
}

variable "location" {
  type        = string
  default     = "francecentral"
  description = "Region of deployment: francecentral"
}

variable "rg_name" {
  type        = string
  default     = "ypsolapp_"
  description = "Resource Group Name"
}

variable "country" {
  type    = string
  default = "fr"
}

variable "backup_retention_days" {
  type    = number
  default = 10
}

variable "adm_login" {
  type      = string
  default   = "mysqladminun"
  sensitive = true
}

variable "adm_passwd" {
  type      = string
  default   = "mYsq1_3dFewhb"
  sensitive = true
}

variable "slot_names" {
  type    = list(string)
  default = ["Development", "Staging"]
}