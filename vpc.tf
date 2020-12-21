resource "aws_vpc" "my_vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "Terraform-VPC"
  }
}

terraform {
  backend "s3" {
    bucket         = "tr-backup-s3-bucket"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-backup"
  }
}

output "VPC_CIDR_BLOCK" {
  value       = aws_vpc.my_vpc.cidr_block
  description = "CidrBlock for Terraform-VPC"
}

output "AWS_REGION_NAME" {
  value       = var.aws_region
  description = "CidrBlock for Terraform-VPC"
}
