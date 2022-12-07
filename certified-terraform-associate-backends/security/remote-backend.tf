data "terraform_remote_state" "eip" {
  backend = "s3"

  config = {
    bucket = "terraform-course-backend"
    key = "network/terraform.tfstate"
    region = "us-east-2"
   }
}