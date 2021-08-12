resource "azurerm_kubernetes_cluster" "k8s" {
    name                = var.cluster_name
    location            = azurerm_resource_group.cicd-task.location
    resource_group_name = azurerm_resource_group.cicd-task.name
    dns_prefix          = var.dns_prefix

    linux_profile {
        admin_username = "ubuntu"

        ssh_key {
            key_data = file(var.ssh_public_key)
        }
    }

    default_node_pool {
        name            = "agentpool"
        node_count      = var.agent_count
        vm_size         = var.vm_size
    }

    identity {
	type	= "SystemAssigned"
    }
    addon_profile {
	http_application_routing {
	    enabled = true
	}
    }

    role_based_access_control {
	enabled = true
    }

    network_profile {
        load_balancer_sku = "Standard"
        network_plugin = "kubenet"
    }

    tags = {
        Environment = "dev"
    }
}

# add the role to the identity to which kubernetes cluster was assigned
resource "azurerm_role_assignment" "k8s_to_acr" {
  scope                = azurerm_container_registry.ascicdacr.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.k8s.kubelet_identity[0].object_id
}