terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>3.0"
    }
  }
}

provider "aws" {
  region = "us-west-2"
  access_key = "<your aws access key>"
  secret_key = "<your aws secret>"
}

resource "aws_instance" "test_ec2" {
  ami = "ami-094125af156557ca2" //Amazon Linux 2 AMI (HVM) - Kernel 5.10, SSD Volume Type
  instance_type = "t2.micro"
}