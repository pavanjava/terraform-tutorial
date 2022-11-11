terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "example-vm" {
  ami = "ami-011899242bb902164" # ubuntu 20.04 LTS
  instance_type = "t2.micro"
}