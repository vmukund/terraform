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

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# CREATE THE NAMESPACE WITH RBAC ROLES
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# resource "kubernetes_namespace" "otel-namespace" {
#  count      = var.create_resources ? 1 : 0
#  metadata {
#    name        = var.name
#    labels      = var.labels
#    annotations = var.annotations
#  }
#}

resource "helm_release" "otel_collector" {
  name       = "otel-collector"
  repository = "https://open-telemetry.github.io/opentelemetry-helm-charts"
  chart      = "opentelemetry-collector"
  version    = "0.97.1"
  namespace  = "otel-ns"

  values = [
    file("${path.module}/values.yaml")
  ]
}
