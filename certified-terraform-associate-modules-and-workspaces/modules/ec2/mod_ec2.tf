resource "aws_instance" "name" {
  ami = var.ami
  instance_type = var.instance_type
  security_groups = [ "default" ]
  key_name = "terraform-key"
}