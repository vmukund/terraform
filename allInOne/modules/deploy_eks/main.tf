
resource "kubernetes_namespace" "estest" {
#  count      = var.create_resources ? 1 : 0
  metadata {
    name        = var.name
    labels      = var.labels
    annotations = var.annotations
  }
}


resource "helm_release" "elasticsearch" {
  name       = "elasticsearch"
  namespace = kubernetes_namespace.estest.metadata.0.name
  repository = "https://helm.elastic.co"
  chart      = "elasticsearch"
  version    = "8.5.1"  // Specify the version of Elasticsearch chart

  set {
    name  = "replicas"
    value = "1"
  }

  values = [
    file("${path.module}/values.yaml")
  ]

   depends_on = [kubernetes_namespace.estest]
}

resource "helm_release" "kibana" {
  name       = "kibana"
  namespace = kubernetes_namespace.estest.metadata.0.name
  repository = "https://helm.elastic.co"
  chart      = "kibana"

  version    = "8.5.1" // Specify the version of Kibana chart

  depends_on = [helm_release.elasticsearch ]
}
