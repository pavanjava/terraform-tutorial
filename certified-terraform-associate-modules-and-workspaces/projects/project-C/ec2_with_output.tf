module "sgmodule" {
  source = "../../modules/security"
}

resource "aws_instance" "ec2_web" {
  ami                    = "ami-0beaa649c482330f7"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [module.sgmodule.ec2_sg_id]
}