terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.75.0"
    }
  }
}

provider "azurerm" {
  features {
    
  }
}

resource "azurerm_resource_group" "openai_rg" {
  name     = "openairg"
  location = "East US"
}

resource "azurerm_cognitive_account" "cg_acct" {
  name                = "openai-ca"
  location            = azurerm_resource_group.openai_rg.location
  resource_group_name = azurerm_resource_group.openai_rg.name
  kind                = "OpenAI"
  sku_name            = "S0"
}

resource "azurerm_cognitive_deployment" "cg_deployment" {
  name                 = "openai-cd"
  cognitive_account_id = azurerm_cognitive_account.cg_acct.id
  model {
    format  = "OpenAI"
    name    = "gpt-35-turbo-16k"
    version = "0613"
  }

  scale {
    type = "Standard"
  }
}