#Using Azure files for k8s volume
resource "azurerm_storage_account" "as-cicd-files" {
  name                     = "ascicdfiles"
  resource_group_name      = azurerm_resource_group.cicd-task.name
  location                 = azurerm_resource_group.cicd-task.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_share" "k8s-files" {
  name                 = "k8s-files"
  storage_account_name = azurerm_storage_account.as-cicd-files.name
  quota                = 1
}
