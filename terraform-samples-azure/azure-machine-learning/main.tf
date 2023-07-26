terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.65.0"
    }
  }
}

provider "azurerm" {
  # Configuration options
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

data "azurerm_client_config" "current_config" {
  
}

resource "azurerm_resource_group" "ml_rg" {
  name = "ml-rg-007"
  location = "West Europe"
}

resource "azurerm_application_insights" "az_app_insights" {
  name                = "az-app-insights-ai"
  location            = azurerm_resource_group.ml_rg.location
  resource_group_name = azurerm_resource_group.ml_rg.name
  application_type    = "web"
}

resource "azurerm_key_vault" "az_key_vault" {
  name                = "mlworkspacekeyvault007"
  location            = azurerm_resource_group.ml_rg.location
  resource_group_name = azurerm_resource_group.ml_rg.name
  tenant_id           = data.azurerm_client_config.current_config.tenant_id
  sku_name            = "premium"
}

resource "azurerm_storage_account" "ml_storage_acct" {
  name                     = "mlwsstorageacct007"
  location                 = azurerm_resource_group.ml_rg.location
  resource_group_name      = azurerm_resource_group.ml_rg.name
  account_tier             = "Standard"
  account_replication_type = "GRS"
}

resource "azurerm_machine_learning_workspace" "ml_workspace" {
  name                    = "example-workspace"
  location                = azurerm_resource_group.ml_rg.location
  resource_group_name     = azurerm_resource_group.ml_rg.name
  application_insights_id = azurerm_application_insights.az_app_insights.id
  key_vault_id            = azurerm_key_vault.az_key_vault.id
  storage_account_id      = azurerm_storage_account.ml_storage_acct.id

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_storage_container" "az_storage_container" {
  name                  = "ml-storage-acct-container"
  storage_account_name  = azurerm_storage_account.ml_storage_acct.name
  container_access_type = "private"
}

resource "azurerm_machine_learning_datastore_blobstorage" "ml_datastore_blobstorage" {
  name                 = "ml_datastore"
  workspace_id         = azurerm_machine_learning_workspace.ml_workspace.id
  storage_container_id = azurerm_storage_container.az_storage_container.resource_manager_id
  account_key          = azurerm_storage_account.ml_storage_acct.primary_access_key
}

