terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.66.0"
    }
  }
}

provider "azurerm" {
  features {
    # any additional features goes here
  }
}

resource "azurerm_resource_group" "iot_rg" {
  name     = "iot-rg"
  location = "West Europe"
}

resource "azurerm_iotcentral_application" "iot_central_app" {
  name                = var.iot_central_app_name
  resource_group_name = azurerm_resource_group.iot_rg.name
  location            = azurerm_resource_group.iot_rg.location
  sub_domain          = var.iot_central_app_subdomain
  display_name = var.iot_central_app_display_name
  sku          = "ST1"

  tags = {
    Environment = "Development"
  }
}
