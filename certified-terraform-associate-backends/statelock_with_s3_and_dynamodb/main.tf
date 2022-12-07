terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>3.0"
    }
  }
  backend "s3" {
    bucket         = "terraform-course-backend"
    key            = "security/terraform.tfstate"
    region         = "us-east-2"
    dynamodb_table = "terraform-state-lock"
  }
}

provider "aws" {
  region = var.region
}

resource "time_sleep" "wait_150_seconds" {
  create_duration = "150s"
}