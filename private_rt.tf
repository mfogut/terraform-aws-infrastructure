resource "aws_route_table" "private_rt" {
  count      = length(aws_nat_gateway.nat_gw)
  vpc_id     = aws_vpc.my_vpc.id
  depends_on = [aws_nat_gateway.nat_gw]

  route {
    cidr_block     = var.open_internet
    nat_gateway_id = aws_nat_gateway.nat_gw[count.index].id
  }

  tags = {
    Name = "Private-RT-${count.index}"
  }
}
