resource "kubernetes_deployment" "backend" {
  metadata {
    name = var.name
    labels = {
      app = var.app_label
    }
  }

  spec {
    replicas = var.replicas

    selector {
      match_labels = {
        app = var.app_label
      }
    }

    template {
      metadata {
        labels = {
          app = var.app_label
        }
      }

      spec {
        container {
          name  = var.container_name
          image = var.image
          image_pull_policy = var.image_pull_policy

          resources {
            limits   = var.resources.limits
            requests = var.resources.requests
          }

          port {
            container_port = var.container_port
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "backend" {
  metadata {
    name = var.name
  }

  spec {
    selector = {
      app = var.app_label
    }

    type = "NodePort"

    port {
      port        = var.service_port
      target_port = var.container_port
      node_port   = var.node_port
    }
  }
}
