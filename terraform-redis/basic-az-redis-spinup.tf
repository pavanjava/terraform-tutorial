terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.31.0"
    }
  }
}

provider "azurerm" {
  # Configuration options
  features {}
}

resource "azurerm_resource_group" "test_redis_cluster" {
  name     = "test-redis-resourcess-b40a9ea8-d35e-49df-bd77-8f9f437a970d"
  location = "West Europe"
}

# NOTE: the Name used for Redis needs to be globally unique
resource "azurerm_redis_cache" "test_redis_cluster" {
  name                = "test-redis-cache-b40a9ea8-d35e-49df-bd77-8f9f437a970d"
  location            = azurerm_resource_group.test_redis_cluster.location
  resource_group_name = azurerm_resource_group.test_redis_cluster.name
  capacity            = 2
  family              = "C"
  sku_name            = "Standard"
  enable_non_ssl_port = false
  minimum_tls_version = "1.2"

  redis_configuration {
  }
}