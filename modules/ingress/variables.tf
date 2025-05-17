variable "name" {}
variable "ingress_class_name" {
  default = "nginx"
}
variable "frontend_host" {}
variable "frontend_service_name" {}
variable "frontend_service_port" {}

variable "backend_host" {}
variable "backend_service_name" {}
variable "backend_service_port" {}

