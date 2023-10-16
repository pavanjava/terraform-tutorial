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

resource "azurerm_resource_group" "stream-rg" {
  name     = var.resource-group-name
  location = var.resource-group-location
}

resource "azurerm_stream_analytics_job" "streaming-job" {
  name                                     = var.stream-job-name
  resource_group_name                      = azurerm_resource_group.stream-rg.name
  location                                 = azurerm_resource_group.stream-rg.location
  compatibility_level                      = "1.2"
  data_locale                              = "en-GB"
  events_late_arrival_max_delay_in_seconds = 60
  events_out_of_order_max_delay_in_seconds = 50
  events_out_of_order_policy               = "Adjust"
  output_error_policy                      = "Drop"
  streaming_units                          = 3

  tags = {
    environment = "Development"
  }

  transformation_query = <<QUERY
    SELECT *
    INTO [adls-output]
    FROM [input-eventhub]
QUERY

}
