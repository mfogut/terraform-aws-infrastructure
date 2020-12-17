resource "aws_vpc" "my_vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "Terraform-VPC"
  }
}

output "VPC_CIDR_BLOCK" {
  value       = aws_vpc.my_vpc.cidr_block
  description = "CidrBlock for Terraform-VPC"
}
