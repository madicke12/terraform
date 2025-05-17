variable "deployment_name" {
  type        = string
  description = "The name of the frontend deployment"
}

variable "app_label" {
  type        = string
  description = "The app label for selectors and pod labels"
}

variable "replicas" {
  type        = number
  description = "Number of replicas"
  default     = 2
}

variable "image" {
  type        = string
  description = "Docker image for the frontend container"
}

variable "container_name" {
  type        = string
  description = "Container name"
}

variable "image_pull_policy" {
  type        = string
  description = "Image pull policy"
  default     = "Always"
}

variable "container_port" {
  type        = number
  description = "Container port exposed"
  default     = 80
}

variable "service_name" {
  type        = string
  description = "Service name"
}

variable "service_port" {
  type        = number
  description = "Port exposed by the service"
  default     = 80
}

variable "node_port" {
  type        = number
  description = "Node port for the service"
}

variable "cpu_limit" {
  type        = string
  description = "CPU limit"
  default     = "500m"
}

variable "memory_limit" {
  type        = string
  description = "Memory limit"
  default     = "256Mi"
}

variable "cpu_request" {
  type        = string
  description = "CPU request"
  default     = "150m"
}

variable "memory_request" {
  type        = string
  description = "Memory request"
  default     = "128Mi"
}

