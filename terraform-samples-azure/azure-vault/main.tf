terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.37.0"
    }
  }
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy    = false
      recover_soft_deleted_key_vaults = false
    }
  }
}

data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "vault-rg" {
  name     = var.vault-rg-name
  location = var.location
}

resource "azurerm_key_vault" "my-vault" {
  name                        = var.vault-name
  location                    = azurerm_resource_group.vault-rg.location
  resource_group_name         = azurerm_resource_group.vault-rg.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions     = var.key-permissions
    secret_permissions  = var.secret-permissions
    storage_permissions = var.storage-permissions
  }
}

resource "azurerm_key_vault_key" "public-key" {
  name         = var.publickey-name
  key_vault_id = azurerm_key_vault.my-vault.id
  key_type     = "RSA"
  key_size     = 4096

  key_opts = var.publickey-opts
}

resource "azurerm_key_vault_secret" "example" {
  name         = "tf-secret"
  value        = "TU6p4UJ&49.5"
  key_vault_id = azurerm_key_vault.my-vault.id
}