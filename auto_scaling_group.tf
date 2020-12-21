resource "aws_autoscaling_group" "app_server_autoscaling_group" {
  name                      = "Terraform-Auto-Scaling-Group"
  launch_configuration      = aws_launch_configuration.app_server.name
  vpc_zone_identifier       = local.private_subnets_id
  target_group_arns         = [aws_lb_target_group.alb_tg.arn]
  health_check_grace_period = 180
  desired_capacity          = 3
  min_size                  = 2
  max_size                  = 5
  health_check_type         = "EC2"
  force_delete              = true

  tag {
    key                 = "Name"
    value               = "App-Server"
    propagate_at_launch = true
  }
}


resource "aws_autoscaling_policy" "cpu_usage_greater80" {
  name                   = "High-CPU-Track"
  autoscaling_group_name = aws_autoscaling_group.app_server_autoscaling_group.name
  policy_type            = "SimpleScaling"
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = 1
  cooldown               = 300
}

#Cloudwatch Metric
resource "aws_cloudwatch_metric_alarm" "cpu_greater80" {
  alarm_name          = "High-CPUUtilization"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "80"
  alarm_description   = "This metric monitors ec2 cpu utilization"
  alarm_actions       = [aws_autoscaling_policy.cpu_usage_greater80.arn]
}

resource "aws_autoscaling_policy" "cpu_usage_less30" {
  name                   = "Low-CPU-Track"
  autoscaling_group_name = aws_autoscaling_group.app_server_autoscaling_group.name
  policy_type            = "SimpleScaling"
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = -1
  cooldown               = 300
}

#Cloudwatch Metric
resource "aws_cloudwatch_metric_alarm" "cpu_less30" {
  alarm_name          = "Low-CPUUtilization"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "30"
  alarm_description   = "This metric monitors ec2 cpu utilization"
  alarm_actions       = [aws_autoscaling_policy.cpu_usage_less30.arn]
}
