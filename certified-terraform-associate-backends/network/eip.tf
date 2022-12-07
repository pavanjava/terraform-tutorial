terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~>3.0"
    }
  }
}

provider "aws" {
  region = var.region
}

resource "aws_eip" "eip_lb" {
  vpc = true
}

output "public_ip_addr" {
  value = aws_eip.eip_lb.public_ip
}