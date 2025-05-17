variable "db_user" {
  description = "PostgreSQL username"
  type        = string
  default     = "odc"
}

variable "db_password" {
  description = "PostgreSQL password"
  type        = string
  default     = "odc123"
}

variable "db_name" {
  description = "PostgreSQL database name"
  type        = string
  default     = "odcdb"
}
