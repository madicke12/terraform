terraform {
  required_providers {
    # aws = {
    #   source  = "hashicorp/aws"
    #   version = "~> 4.16"
    # }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.25"
    }
  }
  required_version = ">= 1.2.0"
}

# provider "aws" {
#   region = "us-west-2"
# }
provider "kubernetes" {
  config_context = "minikube"
  config_path = "~/.kube/config"
}
# resource "aws_instance" "app_server" {
#   ami           = "ami-830c94e3"
#   instance_type = "t2.micro"
#   subnet_id     = aws_subnet.sama_subnet.id
#   vpc_security_group_ids = [aws_security_group.sama_sg.id]
#   associate_public_ip_address = true
#   tags = {
#     Name = "Instance_created_with_terraform"
#   }
# }

# resource "aws_vpc" "sama_vpc" {
#   cidr_block = "10.0.0.0/16"
#   enable_dns_support = true
#   enable_dns_hostnames = true
#   tags = {
#     Name = "sama_vpc"
#   } 
# }

# resource "aws_subnet" "sama_subnet" {
#   vpc_id            = aws_vpc.sama_vpc.id
#   cidr_block        = "10.0.1.0/24"
#   availability_zone = "us-west-2a"
#   map_public_ip_on_launch = true
#   tags = {
#     Name = "sama_subnet1"
#   }
# }

# resource "aws_security_group" "sama_sg" {
#   vpc_id = aws_vpc.sama_vpc.id
#   tags = {
#     Name = "sama_sg"
#   }
# }

# resource "aws_vpc_security_group_ingress_rule" "str" {
#   security_group_id = aws_security_group.sama_sg.id
#   from_port        = 22
#   to_port          = 22
#   cidr_ipv4      = "0.0.0.0/0"
#   ip_protocol = "tcp"
#   description = "Allow SSH access"
# }

# resource "aws_internet_gateway" "sama_igw" {
#   vpc_id = aws_vpc.sama_vpc.id
#   tags = {
#     Name = "sama_igw"
#   }
  
# }

# resource "aws_route_table" "sama_route_table" {
#   vpc_id = aws_vpc.sama_vpc.id
#   tags = {
#     Name = "sama_route_table"
#   }
# }

# resource "aws_route_table_association" "sama_route_table_association" {
#   subnet_id      = aws_subnet.sama_subnet.id
#   route_table_id = aws_route_table.sama_route_table.id
  
# }

# resource "aws_route" "sama_route" {
#   route_table_id         = aws_route_table.sama_route_table.id
#   destination_cidr_block = "0.0.0.0/0"
#   gateway_id            = aws_internet_gateway.sama_igw.id
# }

resource "kubernetes_namespace" "Sama_namespace" {
  metadata {
    name = "samanamespace"
  }
}

module "frontend" {
  source          = "./modules/frontend"
  deployment_name = "front-app"
  app_label       = "front-app"
  replicas        = 2
  image           = "madicke12/front:final"
  container_name  = "frontend-container"
  image_pull_policy = "Always"
  container_port  = 80
  service_name    = "front-service"
  service_port    = 80
  node_port       = 30517
}

module "backend" {
  source = "./modules/backend"

  name             = "backend"
  app_label        = "backend"
  replicas         = 1
  container_name   = "backend"
  image            = "madicke12/backend:v1"
  container_port   = 8000
  service_port     = 8000
  node_port        = 30519

  resources = {
    requests = {
      memory = "128Mi"
      cpu    = "150m"
    }
    limits = {
      memory = "256Mi"
      cpu    = "500m"
    }
  }
}

module "ingress" {
  source                 = "./modules/ingress"
  name                   = "app-ingress"
  ingress_class_name     = "nginx"
  frontend_host          = "frontend.local"
  frontend_service_name  = "front-service"
  frontend_service_port  = 80
  backend_host           = "api.local"
  backend_service_name   = "backend"
  backend_service_port   = 8000
}

module "postgres" {
  source         = "./modules/postgres"
  name           = "postgres"
  db_user        = var.db_user
  db_password    = var.db_password
  db_name        = var.db_name
}

