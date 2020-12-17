#Public Subnets
resource "aws_subnet" "public_subnet" {
  count                   = length(slice(local.az_names, 0, local.end_index_public_subnet))
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.public_subnet_cidr_block[count.index]
  availability_zone       = local.az_names[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "Public-Subnet-${count.index + 1}"
  }
}

output "Public-Subnet-Cidr_Block" {
  value       = aws_subnet.public_subnet.*.cidr_block
  description = "CidrBlock for Public-Subnet"
}
