output "server_name" {
  value = azurerm_mysql_flexible_server.server_azure_mysql.name
}
output "adm_login" {
  value = azurerm_mysql_flexible_server.server_azure_mysql.administrator_login
}

output "adm_passwd" {
  value = azurerm_mysql_flexible_server.server_azure_mysql.administrator_password
}