variable "vnet_name"{
    type = string
}
variable "location"{
    type = string
}
variable "rg_name"{
    type = string
}
variable "address_space"{
    type = list(string)
}
variable "subnet_storage_name"{
    type = string
}
variable "subnet_storage_cidr"{
    type = string
}

variable "tags"{
    type = map(string)
}
