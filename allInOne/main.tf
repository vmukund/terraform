import {
   to = azurerm_resource_group.rg
   id = "/subscriptions/c1fded7b-1017-47e8-909c-d6f5aa5ce87c/resourceGroups/devtest-kubernetes-rg"
}
resource "azurerm_resource_group" "rg" {
  location = "Central India"
  name     = "devtest-kubernetes-rg"
#  lifecycle {
#   prevent_destroy = true
#  }
}

module "create_aks_cluster" {
  source = "./modules/create_aks_cluster"
  aks_resource_group     = azurerm_resource_group.rg
}

provider "kubernetes" {
#  config_raw = var.kube_config
  host                   = module.create_aks_cluster.host
  client_certificate     = base64decode(module.create_aks_cluster.client_certificate)
  client_key             = base64decode(module.create_aks_cluster.client_key)
  cluster_ca_certificate = base64decode(module.create_aks_cluster.cluster_ca_certificate)
}

provider "helm" {
  kubernetes {
   host                   = module.create_aks_cluster.host
   client_certificate     = base64decode(module.create_aks_cluster.client_certificate)
   client_key             = base64decode(module.create_aks_cluster.client_key)
   cluster_ca_certificate = base64decode(module.create_aks_cluster.cluster_ca_certificate)
  }
}

module "deploy_zipkin" {
  source                 =  "./modules/deploy_zipkin"
}

module "deploy_eks" {
  source                 =  "./modules/deploy_eks"
}

module "deploy_cert_mgr" {
  source                 =  "./modules/deploy_cert_mgr"
}

module "deploy_otel_optor" {
  source                 =  "./modules/deploy_otel_optor"
}
