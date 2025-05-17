variable "name" {
  type        = string
  description = "Name for the deployment and service"
}

variable "app_label" {
  type        = string
  description = "App label for selector and match"
}

variable "replicas" {
  type        = number
  description = "Number of pod replicas"
}

variable "container_name" {
  type        = string
  description = "Name of the container"
}

variable "image" {
  type        = string
  description = "Docker image to deploy"
}

variable "container_port" {
  type        = number
  description = "Container port"
}

variable "service_port" {
  type        = number
  description = "Kubernetes service port"
}

variable "node_port" {
  type        = number
  description = "NodePort exposed outside the cluster"
}

variable "image_pull_policy" {
  type        = string
  default     = "Always"
}

variable "resources" {
  type = object({
    requests = map(string)
    limits   = map(string)
  })
  description = "Resource requests and limits"
}
