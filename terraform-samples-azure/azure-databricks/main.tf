terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.51.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "databricks_rg" {
  name     = "databricks-rg"
  location = "West Europe"
}

resource "azurerm_databricks_workspace" "databricks_workspace" {
  name                = "dev-databricks-ws"
  resource_group_name = azurerm_resource_group.databricks_rg.name
  location            = azurerm_resource_group.databricks_rg.location
  sku                 = "standard"
  tags = {
    "Evironment" = "Dev"
  }
}
