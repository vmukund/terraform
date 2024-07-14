provider "kubernetes" {
  config_context = var.kubectl_config_context_name
  config_path    = var.kubectl_config_path
}

resource "kubernetes_namespace" "zipkin_ns" {
#  count      = var.create_resources ? 1 : 0
  metadata {
    name        = var.name
    labels      = var.labels
    annotations = var.annotations
  }
}


resource "kubernetes_deployment" "zipkin" {
  metadata {
    name = "zipkin"
    namespace = kubernetes_namespace.zipkin_ns.metadata.0.name
    labels = {
      app = "zipkin"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "zipkin"
      }
    }

    template {
      metadata {
        labels = {
          app = "zipkin"
        }
      }

      spec {
        container {
          name  = "zipkin"
          image = "openzipkin/zipkin"
        }
      }
    }
  }
  depends_on = [kubernetes_namespace.zipkin_ns]
}

resource "kubernetes_service" "zipkin" {
  metadata {
    name = "zipkin"
    namespace = kubernetes_namespace.zipkin_ns.metadata.0.name
  }

  spec {
    selector = {
      app = kubernetes_deployment.zipkin.metadata[0].labels["app"]
    }

    port {
      port        = 9411
      target_port = 9411
    }

    type = "ClusterIP"
  
  }
}
