resource "aws_autoscaling_policy" "cpu_policy_scale_up" {
  name                   = "cpu_policy_scale_up"
  autoscaling_group_name = aws_autoscaling_group.alb_autoscalling_group.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = "1"
  cooldown               = "300"
  policy_type            = "SimpleScaling"
}

resource "aws_cloudwatch_metric_alarm" "cpu_alarm_scale_up" {
  alarm_name          = "cpu_alarm_scale_up"
  alarm_description   = "cpu_alarm_scale_up"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "30"

  dimensions = {
    "AutoScalingGroupName" = aws_autoscaling_group.alb_autoscalling_group.name
  }

  actions_enabled = true
  alarm_actions   = [aws_autoscaling_policy.cpu_policy_scale_up.arn]
}

resource "aws_autoscaling_policy" "cpu_policy_scale_down" {
  name                   = "cpu_policy_scale_down"
  autoscaling_group_name = aws_autoscaling_group.alb_autoscalling_group.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = "-1"
  cooldown               = "300"
  policy_type            = "SimpleScaling"
}

resource "aws_cloudwatch_metric_alarm" "cpu_alarm_scale_down" {
  alarm_name          = "cpu_alarm_scale_down"
  alarm_description   = "cpu_alarm_scale_down"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "5"

  dimensions = {
    "AutoScalingGroupName" = aws_autoscaling_group.alb_autoscalling_group.name
  }

  actions_enabled = true
  alarm_actions   = [aws_autoscaling_policy.cpu_policy_scale_down.arn]
}

