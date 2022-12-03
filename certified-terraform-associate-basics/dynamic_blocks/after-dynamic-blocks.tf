terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>3.0"
    }
  }
}

provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

variable "sgports" {
  type        = list(number)
  description = "contains the list of ports that need to be part of ingress rules"
  default     = [8200, 8201, 8300, 8301, 9200, 9201]
}

resource "aws_security_group" "dynamic_sg" {
  name        = "dynamic-sg"
  description = "ingress for kubernetes"

  dynamic "ingress" {
    for_each = var.sgports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}
