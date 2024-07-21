provider "kubernetes" {
  config_context = var.kubectl_config_context_name
  config_path    = var.kubectl_config_path
}

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# CREATE THE NAMESPACE WITH RBAC ROLES
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

resource "kubernetes_namespace" "app-ns" {
#  count      = var.create_resources ? 1 : 0
  metadata {
    name        = var.name
    labels      = var.labels
    annotations = var.annotations
  }
}

resource "kubernetes_deployment" "app" {
  metadata {
    name      = "java-app1" 
    namespace = kubernetes_namespace.app-ns.metadata.0.name
  }
  spec {
      selector {
   	 match_labels = {
     		 app: "java-app1"
         }
      }
      template {
         metadata {
             labels = {
                app = "java-app1"
             }
         }
         spec {
          container {
              name  = "java-app1"
              image = "vmukund24/java-app-nosleep:latest" 
              image_pull_policy = "IfNotPresent"
              port {
                container_port = 8080
              }
              env {
                 name = "OTEL_COLLECTOR_ENDPOINT"
#                value = "http://otel-collector.default.svc.cluster.local:4317"
                 value = "http://otel-collector-opentelemetry-collector.otel-ns.svc.cluster.local:4317"
               }
              resources {
                   requests = {
                         memory = "128Mi"
                         cpu = "250m"
                    }
                    limits = {
                         memory = "248Mi"
                         cpu = "1000m"
                     }
              }
           }
         }
       }
    }
    depends_on = [kubernetes_namespace.app-ns]
}    

resource "kubernetes_service" "test" {
  metadata {
    name      = "java-app1"
    namespace = kubernetes_namespace.app-ns.metadata.0.name
  }
  spec {
    selector = {
      app = kubernetes_deployment.app.spec.0.template.0.metadata.0.labels.app
    }
    type = "LoadBalancer"
    port {
      port        = 8080
      target_port = 8080
    }
  }
}
