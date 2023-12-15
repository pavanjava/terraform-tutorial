terraform {
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = "3.85.0"
    }
  }
}

provider "azurerm" {
  features {
    
  }
}

resource "azurerm_resource_group" "devops-rg" {
  name = var.devops-rg-name
  location = var.devops-rg-location
}

resource "azurerm_container_registry" "acr" {
    name = var.acr-name
    resource_group_name = azurerm_resource_group.devops-rg.name
    location = azurerm_resource_group.devops-rg.location
    sku = var.acr-sku
    admin_enabled = true
}