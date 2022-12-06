module "app_instance" {
  source = "../../modules/ec2"
  instance_type = "t2.small"
}  