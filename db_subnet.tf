#Database subnets
resource "aws_subnet" "db_subnet" {
  count                   = length(slice(local.az_names, 0, local.end_index_db_subnet))
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.db_subnet_cidr_block[count.index]
  availability_zone       = local.az_names[count.index]
  map_public_ip_on_launch = false

  tags = {
    Name = "DB-Subnet-${count.index + 1}"
  }
}

output "DB-Subnet-Cidr_Block" {
  value       = aws_subnet.db_subnet.*.cidr_block
  description = "CidrBlock for DB-Subnet"
}
