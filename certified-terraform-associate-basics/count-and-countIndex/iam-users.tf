terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = var.region[0]
  access_key = var.access_key
  secret_key = var.secret_key
}

resource "aws_iam_user" "users" {
  name = var.iam-user-names[count.index]
  count = 4
  path = "/system/"
}