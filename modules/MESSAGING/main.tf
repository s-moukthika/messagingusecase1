resource "azurerm_eventgrid_topic" "eventgrid_topic" {
  name                = var.eventgrid_topic_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
}




resource "azurerm_eventgrid_event_subscription" "eventsub" {
  name  = var.event_subscription_name
  scope = var.rg_id

  storage_queue_endpoint {
    storage_account_id = var.account_id
    queue_name         = var.storage_queue_name
  }
}


resource "azurerm_servicebus_namespace" "servicebus_namespace" {
  name                = var.servicebus_namespace_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  sku                 = var.servicebus_namespace_sku

  
}

resource "azurerm_servicebus_queue" "servicebus_queue" {
  name         = var.servicebus_queue_name
  namespace_id = azurerm_servicebus_namespace.servicebus_namespace.id

  enable_partitioning = var.servicebus_queue_enable_partitioning
}