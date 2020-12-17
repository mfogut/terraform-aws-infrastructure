#Internet Gateway for my_vpc
resource "aws_internet_gateway" "my_vpc_igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "Terraform-IGW"
  }
}

output "Internat_Gateway_ID" {
  value       = aws_internet_gateway.my_vpc_igw.id
  description = "Terraform-IGW ID"
}
