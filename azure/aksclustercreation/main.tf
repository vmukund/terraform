#Below code is commened - It is used while importing exsiting resource group.
#resource "azurerm_resource_group" "rg" {
#   location = "Central India"
#   name     = "/subscriptions/<subcription-id>/resourceGroups/devtest-kubernetes-rg"
#}

resource "azurerm_resource_group" "rg" {
  location = "Central India"
  name     = "devtest-kubernetes-rg"
}

resource "azurerm_kubernetes_cluster" "k8s" {
  location             = azurerm_resource_group.rg.location
  name                 = var.cluster_name
  resource_group_name  = azurerm_resource_group.rg.name
  dns_prefix           = var.dns_prefix
  api_server_access_profile {
        authorized_ip_ranges =  ["90.251.164.15/32", "49.248.202.218/32", "223.233.86.181/32"]
  }
  tags                 = {
    Environment = "BnTDevelopment"
  }

  identity {
    type = "SystemAssigned"
  }

  default_node_pool {
    name       = "agentpool"
    vm_size    = "Standard_D2_v2"
    node_count = var.node_count
  }
  linux_profile {
    admin_username = var.username

    ssh_key {
      key_data = azapi_resource_action.ssh_public_key_gen.output.publicKey
    }
  }
  network_profile {
    network_plugin    = "kubenet"
    load_balancer_sku = "standard"
  }
}
