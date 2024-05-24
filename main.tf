locals {
  env="${terraform.workspace}"
  common_tags = {
    Project = var.project_name
    Environment = local.env
  }
}

resource "azurerm_virtual_network" "example" {
  name                = "vnet_s"
  resource_group_name = var.rg
  location            = var.location
  address_space       = ["10.0.0.0/16"]
  tags = local.common_tags
}
