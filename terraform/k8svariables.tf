#k8s vars
#variable "client_id" {}
#variable "client_secret" {}

variable "agent_count" {
    default = 2
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

