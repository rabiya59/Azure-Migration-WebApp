resource "azurerm_private_dns_zone" "dns_zone" {
  name                = var.private_dns_zone_name
  resource_group_name = var.rg_name

  tags = var.tags
}

# Enables you to manage Private DNS zone Virtual Network Links
resource "azurerm_private_dns_zone_virtual_network_link" "nlink" {
  name                  = var.nlink_name
  private_dns_zone_name = azurerm_private_dns_zone.dns_zone.name
  resource_group_name   = var.rg_name
  virtual_network_id    = var.vnet_id
}