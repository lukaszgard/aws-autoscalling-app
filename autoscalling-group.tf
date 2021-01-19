resource "aws_autoscaling_group" "autoscalling_group_terraform" {
  name     = "Autoscalling_Group_Terraform"
  max_size = 2
  min_size = 1
  # desired_capacity          = 2
  health_check_grace_period = 300
  health_check_type         = "EC2"
  force_delete              = true
  # placement_group           = aws_placement_group.placement_group.id
  vpc_zone_identifier = [var.SUBNET_ID_A, var.SUBNET_ID_B]
  # target_group_arns = []
  # target_group_arns = [aws_alb.alb-terraform.arn]

  launch_template {
    id      = aws_launch_template.template_01.id
    version = aws_launch_template.template_01.latest_version
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
  autoscaling_group_name = aws_autoscaling_group.autoscalling_group_terraform.id
  alb_target_group_arn   = aws_alb_target_group.alb-target-group.arn
}

