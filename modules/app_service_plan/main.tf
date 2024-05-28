resource "azurerm_service_plan" "service_plan" {
  name                = var.app_service_plan_name
  resource_group_name = var.rg_name
  location            = var.location
  os_type             = var.os_type
  sku_name            = var.app_service_plan_sku
  tags = var.tags
}