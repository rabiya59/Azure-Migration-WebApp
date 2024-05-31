resource "azurerm_mysql_flexible_server" "server_azure_mysql" {
  name                   = var.my_sql_flx_server_name
  resource_group_name    = var.rg_name
  location               = var.location
  administrator_login    = var.adm_login
  administrator_password = var.adm_passwd
  sku_name               = var.sku_name
  backup_retention_days = var.backup_retention_days
  geo_redundant_backup_enabled = var.geo_redundant_backup_enabled
  delegated_subnet_id = var.delegated_subnet_id
  private_dns_zone_id = var.private_dns_zone_id

  storage {
    size_gb = var.db_size 
  }

  tags = var.tags
}