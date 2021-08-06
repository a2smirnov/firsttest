resource "azurerm_mysql_server" "mysql-server" {
  name = "my-project-mysqlserver"
  location = azurerm_resource_group.my-project.location
  resource_group_name = azurerm_resource_group.my-project.name
 
  administrator_login = var.mysql-admin-login
  administrator_login_password = var.mysql-admin-password
 
  sku_name = var.mysql-sku-name
  version = var.mysql-version
 
  storage_mb = var.mysql-storage
  auto_grow_enabled = true
  
  backup_retention_days = 7
  geo_redundant_backup_enabled = false
  public_network_access_enabled = true
  ssl_enforcement_enabled = false
}

resource "azurerm_mysql_database" "mysql-db" {
  name                = "api_db"
  resource_group_name = azurerm_resource_group.my-project.name
  server_name         = azurerm_mysql_server.mysql-server.name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}

resource "azurerm_mysql_firewall_rule" "mysql-fw-rule1" {
  name                = "MySQL_restricted_Access"
  resource_group_name = azurerm_resource_group.my-project.name
  server_name         = azurerm_mysql_server.mysql-server.name
  start_ip_address    = var.mysql-access-from-ip1
  end_ip_address      = var.mysql-access-from-ip1
}

#resource "azurerm_mysql_firewall_rule" "mysql-fw-rule2" {
#  name                = "MySQL_restricted_Access"
#  resource_group_name = azurerm_resource_group.my-project.name
#  server_name         = azurerm_mysql_server.mysql-server.name
#  start_ip_address    = var.mysql-access-from-ip2
#  end_ip_address      = var.mysql-access-from-ip2
#}