resource "aws_autoscaling_group" "alb_autoscalling_group" {
  name     = "alb_autoscalling_group"
  max_size = 2
  min_size = 1
  health_check_grace_period = 300
  health_check_type         = "EC2"
  force_delete              = true
  vpc_zone_identifier = [var.subnet_a, var.subnet_b]

  launch_template {
    id      = aws_launch_template.alb_autoscalling_app_template.id
    version = aws_launch_template.alb_autoscalling_app_template.latest_version
  }

  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 50
    }
    triggers = ["tag"]
  }
}

resource "aws_autoscaling_attachment" "asg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.alb_autoscalling_group.id
  alb_target_group_arn   = aws_alb_target_group.alb_target_group.arn
}

