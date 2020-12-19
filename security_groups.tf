resource "aws_security_group" "bashtion_sg" {
  name        = "Bastion-SG"
  description = "Allow SSH traffic"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.open_internet]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.open_internet]
  }

  tags = {
    Name = "Bashtion-SG"
  }
}
#Aplication Load Balancer Security Group
resource "aws_security_group" "alb_sg" {
  name        = "ALB-SG"
  description = "Allow HTTP traffic"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    description = "Traffic from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.open_internet]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.open_internet]
  }

  tags = {
    Name = "ALB-SG"
  }
}
##################################################
#App Server SG
resource "aws_security_group" "app_server_sg" {
  name        = "AppServer-SG"
  description = "Allow all traffic from ALB-SG"
  vpc_id      = aws_vpc.my_vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.open_internet]
  }

  tags = {
    Name = "AppServer-SG"
  }
}

resource "aws_security_group_rule" "app_server_sg_http_rule" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.alb_sg.id
  security_group_id        = aws_security_group.app_server_sg.id
}

resource "aws_security_group_rule" "app_server_sg__ssh_rule" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.bashtion_sg.id
  security_group_id        = aws_security_group.app_server_sg.id
}
