variable "project_name" {
  type = string
  default = "ypsolapp"
  description = "The name of the project"
}

variable "location" {
  type = string
  default = "francecentral"
  description = "Region of deployment: francecentral"
}

variable "rg" {
  type = string
  default = "fr-bidart-fr2"
  description = "Resource Group Name"
}
