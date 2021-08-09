output "acr_login_server" {
  value = azurerm_container_registry.ascicdacr.login_server
}
output "acr_admin_username" {
  value = azurerm_container_registry.ascicdacr.admin_username
}
output "acr_admin_password" {
  value = azurerm_container_registry.ascicdacr.admin_password
  sensitive = true
}
