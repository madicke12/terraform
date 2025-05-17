variable "name" {
  description = "Deployment and label name"
  type        = string
}

variable "image" {
  default = "postgres:latest"
}

variable "secret_name" {
  default = "postgres-credentials"
}

variable "db_user" {}
variable "db_password" {}
variable "db_name" {}

variable "pvc_name" {
  default = "postgres-pvc"
}

variable "storage" {
  default = "1Gi"
}

variable "service_name" {
  default = "database"
}




