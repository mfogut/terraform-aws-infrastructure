resource "aws_autoscaling_group" "app_server_autoscaling_group" {
  count                     = length(aws_subnet.public_subnet)
  name                      = "Terraform-Auto-Scaling-Group-${count.index + 1}"
  max_size                  = 5
  min_size                  = 1
  health_check_grace_period = 180
  health_check_type         = "ELB"
  desired_capacity          = 3
  force_delete              = true
  launch_configuration      = aws_launch_configuration.app_server.name
  vpc_zone_identifier       = [aws_subnet.private_subnet[count.index].id]
  target_group_arns         = [aws_lb_target_group.alb_tg.arn]
}


resource "aws_autoscaling_policy" "cpu_usage_greater80" {
  count                  = length(aws_autoscaling_group.app_server_autoscaling_group)
  name                   = "CPU-Usage"
  autoscaling_group_name = aws_autoscaling_group.app_server_autoscaling_group[count.index].name
  policy_type            = "SimpleScaling"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
}

#Cloudwatch Metric
resource "aws_cloudwatch_metric_alarm" "cpu_greater80" {
  count               = length(aws_autoscaling_policy.cpu_usage_greater80)
  alarm_name          = "High-CPUUtilization"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "80"
  alarm_description   = "This metric monitors ec2 cpu utilization"
  alarm_actions       = aws_autoscaling_policy.cpu_usage_greater80.*.arn
}



resource "aws_autoscaling_policy" "cpu_usage_less35" {
  count                  = length(aws_autoscaling_group.app_server_autoscaling_group)
  name                   = "CPU-Usage"
  autoscaling_group_name = aws_autoscaling_group.app_server_autoscaling_group[count.index].name
  policy_type            = "SimpleScaling"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
}

#Cloudwatch Metric
resource "aws_cloudwatch_metric_alarm" "cpu_less35" {
  count               = length(aws_autoscaling_policy.cpu_usage_less35)
  alarm_name          = "Low-CPUUtilization"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "35"
  alarm_description   = "This metric monitors ec2 cpu utilization"
  alarm_actions       = aws_autoscaling_policy.cpu_usage_less35.*.arn
}
