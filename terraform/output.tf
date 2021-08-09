#output "resource_group_id" {
#  value = azurerm_resource_group.my-project.id
#}
#output "mysql_server" {
#  value = azurerm_mysql_server.as-cicd-dbserver
#  sensitive = true
#}

output "credentials" {
  value = "${data.template_file.cred.rendered}"
}