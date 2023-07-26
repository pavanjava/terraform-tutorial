terraform {
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm",
        version = "3.65.0"
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

resource "azurerm_eventhub" "worker_assignment_eventhub" {
  name                = var.worker_assignment_eventhub_name
  namespace_name      = azurerm_eventhub_namespace.eventhub_ns.name
  resource_group_name = azurerm_resource_group.eventhub_rg.name
  partition_count     = 2
  message_retention   = 1
}

/*resource "azurerm_eventhub" "aisle_eventhub" {
  name                = var.aisle_eventhub_name
  namespace_name      = azurerm_eventhub_namespace.eventhub_ns.name
  resource_group_name = azurerm_resource_group.eventhub_rg.name
  partition_count     = 2
  message_retention   = 1
}

resource "azurerm_eventhub" "bay_eventhub" {
  name                = var.bay_eventhub_name
  namespace_name      = azurerm_eventhub_namespace.eventhub_ns.name
  resource_group_name = azurerm_resource_group.eventhub_rg.name
  partition_count     = 2
  message_retention   = 1
}

resource "azurerm_eventhub" "level_eventhub" {
  name                = var.level_eventhub_name
  namespace_name      = azurerm_eventhub_namespace.eventhub_ns.name
  resource_group_name = azurerm_resource_group.eventhub_rg.name
  partition_count     = 2
  message_retention   = 1
}

resource "azurerm_eventhub" "bin_eventhub" {
  name                = var.bin_eventhub_name
  namespace_name      = azurerm_eventhub_namespace.eventhub_ns.name
  resource_group_name = azurerm_resource_group.eventhub_rg.name
  partition_count     = 2
  message_retention   = 1
}*/