variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "public_subnet_cidr_block" {
  type    = list(any)
  default = ["10.0.0.0/24", "10.0.1.0/24"]
}

variable "private_subnet_cidr_block" {
  type    = list(any)
  default = ["10.0.2.0/24", "10.0.3.0/24"]
}

variable "db_subnet_cidr_block" {
  type    = list(any)
  default = ["10.0.4.0/24", "10.0.5.0/24"]
}

variable "open_internet" {
  type    = string
  default = "0.0.0.0/0"
}

variable "ec2_instance_type" {
  type    = string
  default = "t2.micro"
}
