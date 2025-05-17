resource "kubernetes_secret" "postgres_credentials" {
  metadata {
    name = var.secret_name
  }

  type = "Opaque"

  data = {
    POSTGRES_USER     = var.db_user
    POSTGRES_PASSWORD = var.db_password
    POSTGRES_DB       = var.db_name
  }
}

resource "kubernetes_persistent_volume_claim" "postgres_pvc" {
  metadata {
    name = var.pvc_name
  }

  spec {
    access_modes = ["ReadWriteOnce"]

    resources {
      requests = {
        storage = var.storage
      }
    }
  }
}

resource "kubernetes_deployment" "postgres" {
  metadata {
    name = var.name
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = var.name
      }
    }

    template {
      metadata {
        labels = {
          app = var.name
        }
      }

      spec {
        container {
          name  = var.name
          image = var.image

          port {
            container_port = 5432
          }

          env_from {
            secret_ref {
              name = var.secret_name
            }
          }

          volume_mount {
            name       = "postgres-data"
            mount_path = "/var/lib/postgresql/data"
          }

          readiness_probe {
            exec {
              command = ["pg_isready", "-U", var.db_user]
            }
            initial_delay_seconds = 5
            period_seconds        = 5
          }

          resources {
            requests = {
              memory = "256Mi"
              cpu    = "250m"
            }
            limits = {
              memory = "512Mi"
              cpu    = "1000m"
            }
          }
        }

        volume {
          name = "postgres-data"

          persistent_volume_claim {
            claim_name = var.pvc_name
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "postgres_service" {
  metadata {
    name = var.service_name
  }

  spec {
    selector = {
      app = var.name
    }

    port {
      port        = 5432
      target_port = 5432
    }
  }
}

