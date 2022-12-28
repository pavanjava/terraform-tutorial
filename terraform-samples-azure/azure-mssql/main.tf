terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.37.0"
    }
  }
}

provider "azurerm" {
  features {

  }
}

resource "azurerm_resource_group" "mssql_rg" {
  name     = "mssql-rg"
  location = "East US"
}

resource "azurerm_storage_account" "db_storage_acct" {
  name                     = "tfmssqlsa"
  resource_group_name      = azurerm_resource_group.mssql_rg.name
  location                 = azurerm_resource_group.mssql_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_mssql_server" "mssql_server" {
  name                         = "tf-test-sqlserver"
  resource_group_name          = azurerm_resource_group.mssql_rg.name
  location                     = azurerm_resource_group.mssql_rg.location
  version                      = "12.0"
  administrator_login          = var.username
  administrator_login_password = var.password
}

resource "azurerm_mssql_database" "test_db" {
  name           = "db1"
  server_id      = azurerm_mssql_server.mssql_server.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  license_type   = "LicenseIncluded"
  max_size_gb    = 2
  read_scale     = false
  sku_name       = "S0"
  zone_redundant = false

  tags = {
    environment = "dev"
  }
}