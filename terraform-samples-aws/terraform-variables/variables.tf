variable "instance_name" {
  description = "EC2 instance name"
  type        = string
}

variable "ami" {
  description = "machine image that is to be used in EC2 instance"
  type        = string
  default     = "ami-011899242bb902164" # Ubuntu 20.04 LTS // us-east-1
}

variable "instance_type" {
  description = "ec2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "db_user" {
  description = "username for database"
  type        = string
  default     = "root"
}

variable "db_password" {
  description = "password for database"
  type        = string
  sensitive   = true
}

variable "region" {
  description = "region in which the resource will be spin up"
  type = string
  default = "us-east-1"
}
