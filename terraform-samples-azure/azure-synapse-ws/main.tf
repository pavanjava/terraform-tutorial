terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.65.0"
    }
  }
}

provider "azurerm" {
  features {
    
  }
}

resource "azurerm_resource_group" "synapse_rg" {
  name     = "synapse-rg"
  location = "East US 2"
}

resource "azurerm_storage_account" "synapse_storage_acct" {
  name                     = var.synapse_storage_acct_name
  resource_group_name      = azurerm_resource_group.synapse_rg.name
  location                 = azurerm_resource_group.synapse_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
  is_hns_enabled           = "true"
}

resource "azurerm_storage_data_lake_gen2_filesystem" "synapse_dls_gen2" {
  name               = var.synapse_dls_gen2_filesystem_name
  storage_account_id = azurerm_storage_account.synapse_storage_acct.id
}

resource "azurerm_synapse_workspace" "synapse_ws" {
  name                                 = var.synapse_ws_name
  resource_group_name                  = azurerm_resource_group.synapse_rg.name
  location                             = azurerm_resource_group.synapse_rg.location
  storage_data_lake_gen2_filesystem_id = azurerm_storage_data_lake_gen2_filesystem.synapse_dls_gen2.id

  tags = {
    Env = "development"
  }
}