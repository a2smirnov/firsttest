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
}

resource "azurerm_mysql_database" "api_db" {
  name                = "api_db"
  resource_group_name = azurerm_resource_group.cicd-task.name
  server_name         = azurerm_mysql_server.as-cicd-dbserver.name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}

resource "azurerm_mysql_firewall_rule" "mysql-fw-rule1" {
  name                = "MySQL_access_point_1"
  resource_group_name = azurerm_resource_group.cicd-task.name
  server_name         = azurerm_mysql_server.as-cicd-dbserver.name
  start_ip_address    = var.mysql-access-from-ip1
  end_ip_address      = var.mysql-access-from-ip1
}

resource "azurerm_mysql_firewall_rule" "mysql-fw-rule2" {
  name                = "MySQL_access_point_2"
  resource_group_name = azurerm_resource_group.cicd-task.name
  server_name         = azurerm_mysql_server.as-cicd-dbserver.name
  start_ip_address    = var.mysql-access-from-ip2
  end_ip_address      = var.mysql-access-from-ip2
}

resource "azurerm_mysql_firewall_rule" "mysql-fw-rule3" {
  name                = "MySQL_access_point_3"
  resource_group_name = azurerm_resource_group.cicd-task.name
  server_name         = azurerm_mysql_server.as-cicd-dbserver.name
  start_ip_address    = var.mysql-access-from-ip3
  end_ip_address      = var.mysql-access-from-ip3
}

data "template_file" "cred" {
  template = "${file("${path.module}/cred.tpl")}"
  vars = {
    host = "${azurerm_mysql_server.as-cicd-dbserver.fqdn}"
    db_name = "${azurerm_mysql_database.api_db.name}"
    db_admin_login = "${azurerm_mysql_server.as-cicd-dbserver.administrator_login}"
    db_admin_pass = "${azurerm_mysql_server.as-cicd-dbserver.administrator_login_password}"
  }
}
