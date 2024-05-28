resource "azurerm_linux_web_app_slot" "app_slot" {
  name           = var.slot_name
  app_service_id = var.app_service_id

  site_config {}
}