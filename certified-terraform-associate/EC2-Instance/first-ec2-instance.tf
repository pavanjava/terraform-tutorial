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
  access_key = "AKIA4AQO2XMTTAUCZCXF"
  secret_key = "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"
}

resource "aws_instance" "test_ec2" {
  ami = "ami-094125af156557ca2" //Amazon Linux 2 AMI (HVM) - Kernel 5.10, SSD Volume Type
  instance_type = "t2.micro"
}