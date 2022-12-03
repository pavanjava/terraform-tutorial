terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.33.0"
    }
  }
}

provider "azurerm" {
  # Configuration options
  features {

  }
}

resource "azurerm_resource_group" "db_rg" {
  name     = "api-db-rg"
  location = "West Europe"
}

resource "azurerm_postgresql_server" "postgresql_server" {
  name                = "postgresql-server-tf"
  location            = azurerm_resource_group.db_rg.location
  resource_group_name = azurerm_resource_group.db_rg.name

  sku_name = "B_Gen5_2"

  administrator_login = var.pg_user
  administrator_login_password = var.pg_password
  version = "11"
  ssl_enforcement_enabled = false
  ssl_minimal_tls_version_enforced = "TLSEnforcementDisabled"
}