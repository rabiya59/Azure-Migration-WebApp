terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.99.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "fr-bidart-fr2"
    storage_account_name = "frypsolonfr2"
    container_name       = "archi-ypsolapp"
    key                  = "terraform.tfstate"
  }

}

provider "azurerm" {
  skip_provider_registration = true # This is only required when the User, Service Principal, or Identity running Terraform lacks the permissions to register Azure Resource Providers.
  features {}
}