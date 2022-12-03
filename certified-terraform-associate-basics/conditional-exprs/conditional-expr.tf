terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>3.0"
    }
  }
}

provider "aws" {
  region     = var.region[0]
  access_key = var.access_key
  secret_key = var.secret_key
}

resource "aws_instance" "ec2_dev" {
  ami           = "ami-0b0dcb5067f052a63" //Amazon Linux 2 AMI (HVM) - Kernel 5.10, SSD Volume Type
  instance_type = var.instance_type[0]
  count = var.isdev == true ? 1 : 0
}

resource "aws_instance" "ec2_qa" {
  ami           = "ami-0b0dcb5067f052a63" //Amazon Linux 2 AMI (HVM) - Kernel 5.10, SSD Volume Type
  instance_type = var.instance_type[1]
  count = var.isdev == false ? 1 : 0
}
