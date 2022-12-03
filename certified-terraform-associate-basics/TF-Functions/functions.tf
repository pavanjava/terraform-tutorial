terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>3.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  access_key = var.access_key
  secret_key = var.secret_key
}

locals {
  time = formatdate("DD MMM YYYY hh:mm ZZZ", timestamp())
}

resource "aws_key_pair" "key_pair" {
  key_name = "login-key"
  public_key = file("${path.module}/id_rsa.pub")
}

resource "aws_instance" "dev-instance" {
  ami = lookup(var.ami,var.region)
  instance_type = var.instance_type
  key_name = aws_key_pair.key_pair.key_name
  count = 2
  tags = {
    Name = element(var.tags, count.index)
  }
}

output "timestamp" {
  value = local.time
}