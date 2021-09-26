#Enabling log analytics
resource "azurerm_log_analytics_workspace" "ascicdlogs" {
  name                = "ascicdlogs"
  location            = azurerm_resource_group.cicd-task.location
  resource_group_name = azurerm_resource_group.cicd-task.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}