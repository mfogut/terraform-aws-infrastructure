resource "aws_route_table" "private_rt" {
  count      = length(aws_nat_gateway.nat_gw)
  vpc_id     = aws_vpc.my_vpc.id
  depends_on = [aws_nat_gateway.nat_gw]

  route {
    cidr_block     = var.open_internet
    nat_gateway_id = aws_nat_gateway.nat_gw[count.index].id
  }

  tags = {
    Name = "Private-RT-${count.index + 1}"
  }
}

resource "aws_route_table_association" "private1_rt_association_a" {
  count          = length(aws_subnet.private_subnet)
  subnet_id      = aws_subnet.private_subnet[0].id
  route_table_id = aws_route_table.private_rt[0].id
}

resource "aws_route_table_association" "private1_rt_association_b" {
  count          = length(aws_subnet.db_subnet)
  subnet_id      = aws_subnet.db_subnet[0].id
  route_table_id = aws_route_table.private_rt[0].id
}

resource "aws_route_table_association" "private2_rt_association_a" {
  count          = length(aws_subnet.private_subnet)
  subnet_id      = aws_subnet.private_subnet[1].id
  route_table_id = aws_route_table.private_rt[1].id
}

resource "aws_route_table_association" "private2_rt_association_b" {
  count          = length(aws_subnet.db_subnet)
  subnet_id      = aws_subnet.db_subnet[1].id
  route_table_id = aws_route_table.private_rt[1].id
}
