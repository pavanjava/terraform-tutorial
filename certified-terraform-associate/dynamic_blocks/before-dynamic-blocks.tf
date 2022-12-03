# terraform {
#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = "~>3.0"
#     }
#   }
# }

# provider "aws" {
#   region     = var.region
#   access_key = var.access_key
#   secret_key = var.secret_key
# }

# resource "aws_security_group" "test_sg" {
#   name = "dev-ingress-rules"

#   ingress {
#     from_port   = 8200
#     to_port     = 8200
#     protocol    = "TCP"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   ingress {
#     from_port   = 8201
#     to_port     = 8201
#     protocol    = "TCP"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   ingress {
#     from_port   = 9200
#     to_port     = 9200
#     protocol    = "TCP"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   ingress {
#     from_port   = 9201
#     to_port     = 9201
#     protocol    = "TCP"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   ingress {
#     from_port   = 8300
#     to_port     = 8300
#     protocol    = "TCP"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   ingress {
#     from_port   = 8301
#     to_port     = 8301
#     protocol    = "TCP"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }