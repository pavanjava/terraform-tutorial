terraform {
  required_version = ">0.12.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>3.0"
    }
  }
}

provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

resource "aws_iam_user" "iam_users" {
  name  = "iam-user-${count.index}"
  path  = "/system/"
  count = 3
}

output "arns" {
  value = aws_iam_user.iam_users[*].arn
}