
# resource "azurerm_resource_group" "rg" {
#   location = "Central India"
#   name     = "/subscriptions/c1fded7b-1017-47e8-909c-d6f5aa5ce87c/resourceGroups/devtest-kubernetes-rg"
# }

variable "aks_resource_group" { }


resource "azurerm_kubernetes_cluster" "k8s" {
  location             = var.aks_resource_group.location
  name                 = var.cluster_name
  resource_group_name  = var.aks_resource_group.name
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
#    node_count = var.node_count
    enable_auto_scaling  = true
    max_count            = var.node_count
    min_count            = 1
    node_labels = {
      "nodepool-type"    = "system"
      "environment"      = "dev"
      "nodepoolos"       = "linux"
      "app"              = "system-apps" 
    } 
    tags = {
      "nodepool-type"    = "system"
      "environment"      = "dev"
      "nodepoolos"       = "linux"
      "app"              = "system-apps" 
   } 
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
