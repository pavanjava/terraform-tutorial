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
  access_key = var.access_key
  secret_key = var.secret_key
}

resource "aws_instance" "experimental_ec2" {
  ami           = "ami-0beaa649c482330f7"
  instance_type = "t2.micro"

  provisioner "local-exec" {
    command = "echo ${aws_instance.experimental_ec2.private_ip} >> private_ip.txt"
  }
}