resource "aws_lb_target_group" "alb_tg" {
  name     = "Terraform-ALB-TG"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.my_vpc.id
  tags = {
    Name = "Terraform-ALB-TG"
  }
  health_check {
    path                = "/var/www/html/index.html"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 10
    matcher             = "200"
  }
}
