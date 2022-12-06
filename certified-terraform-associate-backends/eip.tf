terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~>3.0"
    }
  }
}

provider "aws" {
  region = "us-east-2"
}

resource "aws_eip" "eip_lb" {
  vpc = true
}