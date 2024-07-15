provider "helm" {
  kubernetes {
   config_context = var.kubectl_config_context_name
   config_path    = var.kubectl_config_path
  }
}

provider "kubernetes" {
  config_context = var.kubectl_config_context_name
  config_path    = var.kubectl_config_path
}

# Create cert-manager namespace
resource "kubernetes_namespace" "cert_manager_namespace" {
  metadata {
    name = var.namespace
  }
}

# Install cert-manager helm chart
resource "helm_release" "cert_manager" {
  name             = var.helm_release_name
  repository       = var.helm_repository_url
  chart            = var.helm_chart_name
# namespace        = var.namespace
  replace          = "true"
  reuse_values      = true
  force_update      = true
  wait              = true
  max_history       = 1
  version           = "1.14.5"
  namespace         = kubernetes_namespace.cert_manager_namespace.metadata[0].name
# skip_crds         = true
  dependency_update = true

  set {
    name  = "installCRDs"
    value = "true"
  }
 
  values = [
    templatefile("${path.module}/values.yaml.tpl", {
      replica_count = var.replica_count
    })
  ]

  depends_on = [ 
    kubernetes_namespace.cert_manager_namespace
   ]
}
