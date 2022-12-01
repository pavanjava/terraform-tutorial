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
  access_key = "<your access key>"
  secret_key = "<your secret key>"
}

resource "aws_eip" "test_eip" {
  vpc = true
}

resource "aws_instance" "test_ec2" {
  ami = "ami-0b0dcb5067f052a63" //Amazon Linux 2 AMI (HVM) - Kernel 5.10, SSD Volume Type
  instance_type = "t2.micro"
}

resource "aws_eip_association" "eip_ec2_mapping" {
  instance_id = aws_instance.test_ec2.id
  allocation_id = aws_eip.test_eip.id
}