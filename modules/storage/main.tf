resource "azurerm_storage_account" "storage_account" {
  name                     = var.storage_account_name
  resource_group_name      = var.rg_name
  location                 = var.location
  account_tier             = var.storage_account_tier
  account_replication_type = var.storage_account_replication
  tags = var.tags
}

resource "azurerm_storage_container" "container" {
  name                  = var.container_name
  storage_account_name  = var.storage_account_name
  container_access_type = var.container_access

  depends_on = [azurerm_storage_account.storage_account]
}

resource "azurerm_storage_share" "container_sas" {
  name                 = var.container_sas_name
  storage_account_name = azurerm_storage_account.storage_account.name
  quota                = var.container_sas_quota #50

  acl {
    id = "MTIzNDU2Nzg5MDEyMzQ1Njc4OTAxMjM0NTY3ODkwMTI"

    access_policy {
      permissions = var.container_sas_permission #"rwd"
      start       = var.container_sas_start #"2024-05-30T10:32:21.0000000Z"
    }
  }
  depends_on = [azurerm_storage_container.container]
}