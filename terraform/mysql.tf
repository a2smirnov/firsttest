#Azure cloud MySQL server
resource "azurerm_mysql_server" "as-cicd-dbserver" {
  name = "as-cicd-dbserver"
  resource_group_name = azurerm_resource_group.cicd-task.name
  location = azurerm_resource_group.cicd-task.location
 
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
  tags = var.tags
}

#Dabatase for backend application
resource "azurerm_mysql_database" "api_db" {
  name                = "api_db"
  resource_group_name = azurerm_resource_group.cicd-task.name
  server_name         = azurerm_mysql_server.as-cicd-dbserver.name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}

#Permiting access from Azure internal IPs and from selected external addresses
resource "azurerm_mysql_firewall_rule" "mysql-fw-rule" {
  count 	      = length(var.mysql-allowed-ip)
  name                = "MySQL_access_point_${count.index}"
  resource_group_name = azurerm_resource_group.cicd-task.name
  server_name         = azurerm_mysql_server.as-cicd-dbserver.name
  start_ip_address    = element(var.mysql-allowed-ip, count.index)
  end_ip_address      = element(var.mysql-allowed-ip, count.index)
}

#DB credential output template
data "template_file" "cred" {
  template = "${file("${path.module}/cred.tpl")}"
  vars = {
    host = "${azurerm_mysql_server.as-cicd-dbserver.fqdn}"
    db_name = "${azurerm_mysql_database.api_db.name}"
    db_admin_login = "${azurerm_mysql_server.as-cicd-dbserver.administrator_login}"
    db_admin_pass = "${azurerm_mysql_server.as-cicd-dbserver.administrator_login_password}"
  }
}
