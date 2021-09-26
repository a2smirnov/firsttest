#Variables definition and default values
#General vars
variable resource_group_name {
    type = string
    default = "as-cicd-task"
}
variable location {
    type = string
    default = "West Europe"
}
variable tags {
    type = map
    default = {"owner" = "Aleksei_Smirnov1"}
    description = "Resources labels"
}
#MySQL vars
variable "mysql-admin-login" {
  type = string
  description = "Login to authenticate to MySQL Server"
}
variable "mysql-admin-password" {
  type = string
  description = "Password to authenticate to MySQL Server"
}
variable "mysql-version" {
  type = string
  description = "MySQL Server version to deploy"
  default = "8.0"
}
variable "mysql-sku-name" {
  type = string
  description = "MySQL SKU Name"
  default = "B_Gen4_1"
}
variable "mysql-storage" {
  type = string
  description = "MySQL Storage in MB"
  default = "5120"
}

variable "mysql-allowed-ip" {
  type = list(string)
  default = ["0.0.0.0"]
}

#k8s vars
variable "agent_count" {
    default = 2
}
variable "vm_size" {
    default = "standard_a2_v2"
}
variable "ssh_public_key" {
    default = "~/.ssh/id_rsa.pub"
}
variable "dns_prefix" {
    default = "as-cicd-k8s"
}
variable cluster_name {
    default = "as-cicd-k8s"
}
