terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>4.47.0"
    }
  }
}

provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

resource "aws_security_group" "netcat_sg" {
  name = "tf_netcat_sg"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    cidr_blocks = [ "0.0.0.0/0" ]
    description = "public outbound traffic"
    from_port = 0
    ipv6_cidr_blocks = [ "::/0" ]
    protocol = "-1"
    to_port = 0
  } 
}

resource "aws_instance" "ec2_netcat" {
  ami             = "ami-0beaa649c482330f7"
  instance_type   = "t2.micro"
  key_name        = "tf-tutorial"
  vpc_security_group_ids = [ "${aws_security_group.netcat_sg.id}"]

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ec2-user"
    private_key = file("./tf-tutorial.pem")
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum install -y nc"
    ]
  }
}

output "ec2_public_ip" {
  value = aws_instance.ec2_netcat.public_ip
}
