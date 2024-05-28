resource "azurerm_app_service_source_control" "github_repo" {
  app_id   = var.app_id
  repo_url           = var.repo_url
  branch             = var.main_branch
  use_manual_integration = var.use_manual_integration
  

}

resource "azurerm_source_control_token" "example" {
  type  = var.type
  token = var.token
}