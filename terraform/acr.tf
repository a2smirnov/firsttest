#Azure container registry for CI/CD pipelines
resource "azurerm_container_registry" "ascicdacr" {
  name                = "ascicdacr"
  resource_group_name = azurerm_resource_group.cicd-task.name
  location            = azurerm_resource_group.cicd-task.location
  sku                 = "Basic"
  admin_enabled       = true
  tags                = var.tags
}
