resource "aws_lb_target_group" "alb_tg" {
  name        = "Terraform-ALB-TG"
  target_type = "instance"
  protocol    = "HTTP"
  port        = 80
  vpc_id      = aws_vpc.my_vpc.id
  tags = {
    Name = "Terraform-ALB-TG"
  }
  health_check {
    protocol            = "HTTP"
    path                = "/index.html"
    healthy_threshold   = 2
    unhealthy_threshold = 3
    timeout             = 5
    interval            = 30
    matcher             = "200"
  }
}
