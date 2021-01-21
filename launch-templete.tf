resource "aws_launch_template" "template_01" {
  name                                 = "template_01"
  image_id                             = var.amis[var.aws_region]
  instance_initiated_shutdown_behavior = "terminate"
  instance_type                        = "t2.micro"
  #key_name                             = aws_key_pair.mykeypair.key_name
  vpc_security_group_ids               = [aws_security_group.allow-ssh.id, aws_security_group.allow-tls.id, aws_security_group.allow-http.id]
  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "template_stateless_app"
    }
  }
  user_data = data.template_cloudinit_config.cloudinit-example.rendered
}

output "template_version" {
  value = aws_launch_template.template_01.latest_version
}
