output "storage_account_name" {
  value = azurerm_storage_account.storage_account.name
}

output "storage_account_id" {
  value = azurerm_storage_account.storage_account.id
}

output "container_name" {
  value = azurerm_storage_container.container.name
}

output "container_id" {
  value = azurerm_storage_container.container.id
}

output "sas_url" {
  value = azurerm_storage_share.container_sas.url
}
