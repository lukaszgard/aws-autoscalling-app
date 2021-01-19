resource "aws_alb" "alb-terraform" {
  name               = "alb-terraform"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow-http.id]
  subnets            = [var.SUBNET_ID_A, var.SUBNET_ID_B]

  tags = {
    Name = "alb-terraform"
  }
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_alb.alb-terraform.arn
  port              = "80"
  protocol          = "HTTP"
  
  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.alb-target-group.arn
  }
}

resource "aws_alb_target_group" "alb-target-group" {
  name     = "alb-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.VPC_MAIN_ID
}

output "alb-dns-name" {
    value = aws_alb.alb-terraform.dns_name
}