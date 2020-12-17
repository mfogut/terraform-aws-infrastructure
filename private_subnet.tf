#Private Subnets
resource "aws_subnet" "private_subnet" {
  count                   = length(slice(local.az_names, 0, local.end_index_private_subnet))
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.private_subnet_cidr_block[count.index]
  availability_zone       = local.az_names[count.index]
  map_public_ip_on_launch = false

  tags = {
    Name = "Private-Subnet-${count.index + 1}"
  }
}

output "Private-Subnet-Cidr_Block" {
  value       = aws_subnet.private_subnet.*.cidr_block
  description = "CidrBlock for Private-Subnet"
}
