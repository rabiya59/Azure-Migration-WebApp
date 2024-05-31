variable "storage_account_name"{
    type = string
}
variable "rg_name"{
    type = string
}
variable "location"{
    type = string
}
variable "storage_account_tier"{
    type = string
}
variable "storage_account_replication"{
    type = string
}
variable "container_name"{
    type = string
}
variable "container_access"{
    type = string
}
variable "tags" {
  type = map(string)
}
variable "container_sas_name"{
    type = string
}
variable "container_sas_quota"{
    type = number
}
variable "container_sas_permission"{
    type = string
}
variable "container_sas_start"{
    type = string
}