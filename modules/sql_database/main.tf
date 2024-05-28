resource "azurerm_mysql_flexible_database" "db_azure_mysql" {
  name                = var.sql_db_name
  resource_group_name = var.rg_name
  server_name         = var.server_name
  charset             = var.charset
  collation           = var.collation
}