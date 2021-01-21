resource "aws_alb" "alb" {
  name               = "alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow_http.id]
  subnets            = [var.subnet_a, var.subnet_b]

  tags = {
    Name = "alb-autoscalling-app"
  }
}

resource "aws_alb_listener" "alb_listener_http" {
  load_balancer_arn = aws_alb.alb.arn
  port              = "80"
  protocol          = "HTTP"
  
  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.alb_target_group.arn
  }
}

resource "aws_alb_target_group" "alb_target_group" {
  # name     = "alb-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_main
}

output "alb-dns-name" {
    value = aws_alb.alb.dns_name
}