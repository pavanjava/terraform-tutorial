terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = var.region
}

#local variable
locals {
  additional_tags = "additional tags for a resource goes here"
}

resource "aws_instance" "instance" {
  ami           = var.ami
  instance_type = var.instance_type

  tags = {
    key       = "tfpostgresinstance01"
    name      = var.instance_name
    extra_tag = local.additional_tags
  }
}

resource "aws_db_instance" "pg_instance" {
  allocated_storage   = 20
  storage_type        = "gp2"
  engine              = "postgres"
  engine_version      = "12"
  instance_class      = "db.t2.micro"
  name                = "testpg"
  username            = var.db_user
  password            = var.db_password
  skip_final_snapshot = true
}
