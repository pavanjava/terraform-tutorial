terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.38.0"
    }
  }
}

provider "azurerm" {
  features {

  }
  # Configuration options
}

resource "azurerm_resource_group" "storage-rg" {
  name     = var.resource-group-name
  location = var.resource-group-location
}

resource "azurerm_storage_account" "storage-acct" {
  name                     = var.storage-acct-name
  resource_group_name      = azurerm_resource_group.storage-rg.name
  location                 = azurerm_resource_group.storage-rg.location
  account_tier             = var.storage-account-tier
  account_replication_type = var.storage-account-replication-type
}

resource "azurerm_storage_table" "storage-table" {
  name                 = var.storage-table-name
  storage_account_name = azurerm_storage_account.storage-acct.name
}
