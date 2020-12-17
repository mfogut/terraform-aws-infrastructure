resource "aws_lb" "alb" {
  name               = "Terraform-ALB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = aws_subnet.public_subnet.*.id


  tags = {
    Name = "Terraform-ALB"
  }
}
