terraform {
  backend "s3" {
    bucket = "terraform-course-backend"
    key = "security/terraform.tfstate"
    region = "us-east-2"
  }
}