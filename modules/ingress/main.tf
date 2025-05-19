resource "kubernetes_ingress_v1" "this" {
  metadata {
    name = var.name
    annotations = {
      "nginx.ingress.kubernetes.io/rewrite-target" = "/"
    }
  }

  spec {
    ingress_class_name = var.ingress_class_name

    rule {
      host = var.frontend_host
      http {
        path {
          path     = "/"
          path_type = "Prefix"

          backend {
            service {
              name = var.frontend_service_name
              port {
                number = var.frontend_service_port
              }
            }
          }
        }
      }
    }

    rule {
      host = var.backend_host
      http {
        path {
          path     = "/"
          path_type = "Prefix"
          backend {
            service {
              name = var.backend_service_name
              port {
                number = var.backend_service_port
              }
            }
          }
        }
      }
    }
  }
}

