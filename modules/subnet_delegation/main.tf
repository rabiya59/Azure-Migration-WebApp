resource "azurerm_subnet" "subnet_delegation" {
  name                 = var.delegated_subnet_name
  resource_group_name  = var.rg_name
  virtual_network_name = var.vnet_name
  address_prefixes     = var.delegated_subnet_cidr

  delegation {
    name = var.delegation_name

    service_delegation {
      name    = var.service_delegation
      actions = var.service_delegation_action
    }
  }
}