terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.65.0"
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

resource "azurerm_storage_account" "storact-acct" {
  name                     = var.storact-acct-name
  resource_group_name      = azurerm_resource_group.storage-rg.name
  location                 = azurerm_resource_group.storage-rg.location
  account_tier             = var.storact-account-tier
  account_replication_type = var.storage-account-replication-type
  
}

resource "azurerm_storage_queue" "storage-event-queue" {
  name = var.storage-event-queue-name
  storage_account_name = azurerm_storage_account.storact-acct.name
}