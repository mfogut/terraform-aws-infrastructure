resource "aws_eip" "nat_eip" {
  count = 2
  vpc   = true

  tags = {
    Name = "NAT-EIP"
  }
}
