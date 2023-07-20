terraform {
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm",
        version = "3.52.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "eventhub_rg" {
    name = var.rg_name
    location = "West Europe"
}

resource "azurerm_eventhub_namespace" "eventhub_ns" {
  name                = var.ns_name
  location            = azurerm_resource_group.eventhub_rg.location
  resource_group_name = azurerm_resource_group.eventhub_rg.name
  sku                 = "Standard"
  capacity            = 1
  tags = {
    environment = "development"
  }
}

resource "azurerm_eventhub" "eventhub" {
  name                = var.eventhub_name
  namespace_name      = azurerm_eventhub_namespace.eventhub_ns.name
  resource_group_name = azurerm_resource_group.eventhub_rg.name
  partition_count     = 2
  message_retention   = 1
}