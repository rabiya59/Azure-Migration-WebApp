variable "delegated_subnet_name"{
    type = string
}
variable "rg_name"{
    type = string
}
variable "vnet_name"{
    type = string
}
variable "delegated_subnet_cidr"{
    type = list(string)
}
variable "service_delegation"{
    type = string
}
variable "delegation_name" {
  type = string
}
variable "service_delegation_action" {
  type= list(string)
}