resource "aws_nat_gateway" "nat_gw" {
  count         = length(slice(local.az_names, 0, local.end_index_public_subnet))
  allocation_id = aws_eip.nat_eip[count.index].id
  subnet_id     = aws_subnet.public_subnet[count.index].id

  tags = {
    Name = "NAT-GW-Public-Subnet-${count.index + 1}"
  }
}

output "NAT_GW_EIP" {
  value       = aws_eip.nat_eip.*.public_ip
  description = "Elastic IP for NAT-GW"
}
