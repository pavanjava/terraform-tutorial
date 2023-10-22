terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.75.0"
    }
  }
}

provider "azurerm" {
  features {

  }
  # Configuration options
}

resource "azurerm_resource_group" "rg" {
  name     = "ai001"
  location = "eastus"
}

resource "azurerm_cognitive_account" "document_intelligent" {
  name                = "document-intelligence"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  
  kind                = "FormRecognizer"
  sku_name            = "S0"
  tags = {
    Evironment = "Dev"
  }
}

resource "azurerm_cognitive_account" "openai" {
  name                = "OpenAI"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  kind                = "OpenAI"
  sku_name            = "S0"
  tags = {
    Evironment = "Dev"
  }
}
