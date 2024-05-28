resource "azurerm_linux_web_app" "web_app" {
  name                = var.app_service_name
  resource_group_name = var.rg_name
  location            = var.location
  service_plan_id     = var.service_plan_id

  site_config {
    application_stack {
      php_version = var.php_version
  }
  } 

  app_settings = {
    #"SOME_KEY" = "some-value"
  }

  provisioner "local-exec" {
    command = "az webapp vnet-integration add --name ${var.app_service_name} --resource-group ${var.rg_name}  --vnet ${var.vnet_name} --subnet ${var.subnet_id}"
    interpreter = ["PowerShell", "-command" ]
  }

  

  # connection_string {
  #   name  = "Database"
  #   type  = "SQLAzure"
  #   value = "Server=tcp:azurerm_mssql_server.sql.fully_qualified_domain_name Database=azurerm_mssql_database.db.name;User ID=azurerm_mssql_server.sql.administrator_login;Password=azurerm_mssql_server.sql.administrator_login_password;Trusted_Connection=False;Encrypt=True;"
  # }

  tags = var.tags
}