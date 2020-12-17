resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "Public-Subnets-RT"
  }

  route {
    cidr_block = var.open_internet
    gateway_id = aws_internet_gateway.my_vpc_igw.id
  }
}

resource "aws_route_table_association" "public_rt_association" {
  count          = length(slice(local.az_names, 0, local.end_index_public_subnet))
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public_rt.id
}
