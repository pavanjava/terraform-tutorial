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

data "aws_ami" "dynamic_ami" {
  most_recent = true
  owners = [ "amazon" ]

  filter {
    name = "name"
    values = [ "amzn2-ami-hvm*" ]
  }
}

resource "aws_instance" "app_ec2_instance" {
  ami = data.aws_ami.dynamic_ami.id
  instance_type = var.instance_type
}
