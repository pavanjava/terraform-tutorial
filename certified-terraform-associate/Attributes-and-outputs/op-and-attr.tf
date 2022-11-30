terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>3.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
  access_key = "AKIA4AQO2XMT2QIN5RTB"
  secret_key = "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"
}

resource "aws_eip" "test_eip" {
  vpc = true
}

output "eip" {
  value = aws_eip.test_eip.public_ip
}

resource "aws_s3_bucket" "test_s3" {
  bucket = "tf-s3-001"
}

output "s3_domain_name" {
  value = aws_s3_bucket.test_s3.bucket_domain_name
}