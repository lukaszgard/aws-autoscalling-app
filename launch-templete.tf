resource "aws_launch_template" "alb_autoscalling_app_template" {
  name                                 = "alb_autoscalling_app_template"
  image_id                             = var.amis[var.aws_region]
  instance_initiated_shutdown_behavior = "terminate"
  instance_type                        = "t2.micro"
  vpc_security_group_ids               = [aws_security_group.allow_tls.id, aws_security_group.allow_http.id]
  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "template_stateless_app"
    }
  }
  user_data = data.template_cloudinit_config.cloudinit.rendered
}

output "template_version" {
  value = aws_launch_template.alb_autoscalling_app_template.latest_version
}
