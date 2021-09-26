#Project vars setup
resource_group_name  = "as-cicd-task"
location             = "West Europe"
mysql-admin-login    = "testadmin"
mysql-admin-password = "Gfccdjhl0"
mysql-version        = "8.0"
mysql-sku-name       = "B_Gen5_1"
mysql-storage        = "5120"
mysql-allowed-ip     = ["0.0.0.0"]
vm_size              = "standard_a2_v2"
agent_count          = 2
tags = {
    "owner" = "Aleksei_Smirnov1"
    "project" = "CICD diploma task"
    }