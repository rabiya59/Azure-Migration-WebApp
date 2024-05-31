locals {
  env = terraform.workspace
  common_tags = {
    Project     = var.project_name
    Environment = local.env
  }
}

module "rg" {
  source   = "./modules/rg"
  rg_name  = "rg-${var.project_name}-${terraform.workspace}-${var.country}"
  location = var.location
  tags     = local.common_tags
}

module "vnet" {
  source              = "./modules/vnet"
  vnet_name           = "vnet-${var.project_name}-${terraform.workspace}-${var.country}"
  address_space       = ["10.0.0.0/16"]
  rg_name             = module.rg.rg_name
  location            = var.location
  subnet_storage_name = "subnet_storage"
  subnet_storage_cidr = "10.0.3.0/28"
  tags                = local.common_tags

  depends_on = [module.rg]
}

module "subnet_frontend" {
  source                    = "./modules/subnet_delegation"
  rg_name                   = module.rg.rg_name
  vnet_name                 = module.vnet.vnet_name
  delegated_subnet_name     = "subnet_frontend"
  delegated_subnet_cidr     = ["10.0.1.0/27"]
  delegation_name           = "appServiceDelegation"
  service_delegation        = "Microsoft.Web/serverFarms"
  service_delegation_action = ["Microsoft.Network/virtualNetworks/subnets/action"]

  depends_on = [module.rg, module.vnet]
}

module "subnet_backend" {
  source                    = "./modules/subnet_delegation"
  rg_name                   = module.rg.rg_name
  vnet_name                 = module.vnet.vnet_name
  delegated_subnet_name     = "subnet_backend"
  delegated_subnet_cidr     = ["10.0.2.0/28"]
  delegation_name           = "mysqlDelegation"
  service_delegation        = "Microsoft.DBforMySQL/flexibleServers"
  service_delegation_action = ["Microsoft.Network/virtualNetworks/subnets/action"]

  depends_on = [module.rg, module.vnet]
}

module "dns_zone" {
  source                = "./modules/dns"
  private_dns_zone_name = "${var.project_name}.mysql.database.azure.com"
  rg_name               = module.rg.rg_name
  tags                  = local.common_tags
  nlink_name            = "mysqlVnetZone${var.project_name}.com"
  vnet_id               = module.vnet.vnet_id

  depends_on = [module.vnet, module.rg]
}

module "storage" {
  source                      = "./modules/storage"
  storage_account_name        = "storage${var.project_name}${terraform.workspace}${var.country}"
  rg_name                     = module.rg.rg_name
  location                    = var.location
  storage_account_tier        = "Standard"
  storage_account_replication = "LRS"
  container_name              = "${var.project_name}${terraform.workspace}${var.country}"
  container_access            = "private"
  container_sas_name          = "logs${var.project_name}${terraform.workspace}${var.country}"
  container_sas_quota         = 50
  container_sas_permission    = "rwd"
  container_sas_start         = "2024-05-31T10:32:21.0000000Z"
  tags                        = local.common_tags

  depends_on = [module.rg]
}

module "azure_mysql_server" {
  source                       = "./modules/sql_server"
  my_sql_flx_server_name       = "sql-server-${var.project_name}-${terraform.workspace}-${var.country}"
  rg_name                      = module.rg.rg_name
  location                     = var.location
  adm_login                    = var.adm_login
  adm_passwd                   = var.adm_passwd
  sku_name                     = "B_Standard_B1s"
  backup_retention_days        = var.backup_retention_days
  delegated_subnet_id          = module.subnet_backend.subnet_id
  geo_redundant_backup_enabled = false
  db_size                      = "20"
  private_dns_zone_id          = module.dns_zone.private_dns_zone_id
  tags                         = local.common_tags

  depends_on = [module.rg, module.dns_zone, module.vnet, module.subnet_backend]
}

# # module "azure_mysql_db" {
# #   source      = "./modules/sql_database"
# #   server_name = module.azure_mysql_server.server_name
# #   sql_db_name = "db-${var.project_name}-${terraform.workspace}-${var.country}"
# #   rg_name     = module.rg.rg_name
# #   charset     = "utf8"
# #   collation   = "utf8_unicode_ci"

# #   depends_on = [module.azure_mysql_server]
# # }

# # # resource "null_resource" "restore_database" {
# # #   provisioner "local-exec" {
# # #     command = <<EOT
# # #       az sql db restore \
# # #         --dest-name example-sqldatabase \
# # #         --edition Standard \
# # #         --service-objective S1 \
# # #         --resource-group ${azurerm_resource_group.example.name} \
# # #         --server-name ${azurerm_sql_server.example.name} \
# # #         --name example-sqldatabase-backup \
# # #         --restore-point-in-time 2022-01-01T00:00:00Z
# # #     EOT
# # #   }

# # #   depends_on = [azurerm_sql_database.example]
# # # }

module "azure_app_sevice_plan" {
  source                = "./modules/app_service_plan"
  app_service_plan_name = "asp-${var.project_name}-${terraform.workspace}-${var.country}"
  rg_name               = module.rg.rg_name
  location              = var.location
  os_type               = "Linux"
  app_service_plan_sku  = "P1v2"
  tags                  = local.common_tags

  depends_on = [module.rg]
}

module "azure_app_sevice" {
  source             = "./modules/app_service"
  app_service_name   = "app-${var.project_name}-${terraform.workspace}-${var.country}"
  rg_name            = module.rg.rg_name
  location           = var.location
  service_plan_id    = module.azure_app_sevice_plan.app_service_plan_id
  php_version        = "8.2"
  vnet_name          = module.vnet.vnet_name
  subnet_id          = module.subnet_frontend.subnet_id
  app_logs_container = module.storage.sas_url
  app_logs_retention = 30
  app_error_level    = "Error"
  sql_server         = "10.0.2.4"
  sql_db_name        = "db_ypsolap"
  db_user_name       = module.azure_mysql_server.adm_login
  db_password        = module.azure_mysql_server.adm_passwd

  tags = local.common_tags

  depends_on = [module.azure_app_sevice_plan, module.azure_mysql_server, module.vnet, module.subnet_frontend]
}

module "azure_app_slot" {
  source         = "./modules/app_service_slot"
  for_each       = toset(var.slot_names)
  slot_name      = each.value
  app_service_id = module.azure_app_sevice.app_service_id

  depends_on = [module.azure_app_sevice]
}

# module "github_scm" {
#   source                 = "./modules/scm_app_service"
#   main_branch            = "main"
#   repo_url               = "https://github.com/guido1990/hello_php.git"
#   app_id                 = module.azure_app_sevice.app_service_id
#   use_manual_integration = false
#   type                   = "GitHub"
#   token                  = "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"

#   depends_on = [module.rg]

# }

# resource "null_resource" "app_service_link_repo_code" {
#   provisioner "local-exec" {
#   command = "az webapp deployment source config --repo-url https://github.com/guido1990/test_php.git --branch prod  --name ${module.azure_app_sevice.app_service_name}  --resource-group ${module.rg.rg_name}"
#   }
#   depends_on = [module.azure_app_sevice]
# }