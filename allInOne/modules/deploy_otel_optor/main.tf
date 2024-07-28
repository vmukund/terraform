

resource "kubernetes_namespace" "otel-namespace" {
#  count      = var.create_resources ? 1 : 0
  metadata {
    name        = var.name
    labels      = var.labels
    annotations = var.annotations
  }
}

resource "helm_release" "opentelemetry-operator" {
  name                = "opentelemetry-operator"
#  namespace           = "otel-operator"
#  create_namespace    = true
  repository          = "https://open-telemetry.github.io/opentelemetry-helm-charts"
  chart               = "opentelemetry-operator"
  version             = "0.48.0"
  namespace           = kubernetes_namespace.otel-namespace.metadata.0.name
  

#  values = [
#    file("${path.module}/values.yaml")
#  ]

#  set {
#    name  = "manager.collectorImage.repository"
#    value = ""
#  }

   depends_on = [kubernetes_namespace.otel-namespace]
}
  

