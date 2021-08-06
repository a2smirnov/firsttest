output "resource_group_id" {
  value = azurerm_resource_group.my-project.id
}
output "mysql_db_id" {
  value = azurerm_mysql_database.mysql-db.id
}
output "mysql_server" {
  value = azurerm_mysql_server.mysql-server
  sensitive = true
}
output "mysql_server_id" {
  value = azurerm_mysql_server.mysql-server.id
}
