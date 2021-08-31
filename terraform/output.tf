#MySQL
output "credentials" {
  value = "${data.template_file.cred.rendered}"
}
#Registry
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
#k8s
output "client_key" {
    value = azurerm_kubernetes_cluster.k8s.kube_config.0.client_key
}
output "client_certificate" {
    value = azurerm_kubernetes_cluster.k8s.kube_config.0.client_certificate
}
output "cluster_ca_certificate" {
    value = azurerm_kubernetes_cluster.k8s.kube_config.0.cluster_ca_certificate
}
output "cluster_username" {
    value = azurerm_kubernetes_cluster.k8s.kube_config.0.username
}
output "cluster_password" {
    value = azurerm_kubernetes_cluster.k8s.kube_config.0.password
}
output "kube_config" {
    value = azurerm_kubernetes_cluster.k8s.kube_config_raw
    sensitive = true
}
output "host" {
    value = azurerm_kubernetes_cluster.k8s.kube_config.0.host
}
output "http_router_url" {
    value = azurerm_kubernetes_cluster.k8s.addon_profile.0.http_application_routing.0.http_application_routing_zone_name
}
#Azure files
output "storage_account_name" {
    value = azurerm_storage_account.as-cicd-files.name
}
output "storage_account_secret" {
    value = azurerm_storage_account.as-cicd-files.primary_access_key
    sensitive = true
}
