terraform {
  backend "s3" {
    bucket = "terraform-course-backend"
    key = "network/terraform.tfstate"
    region = "us-east-2"
  }
}