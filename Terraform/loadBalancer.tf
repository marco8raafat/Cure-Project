resource "aws_lb" "alb" {
  name               = "cure-alb"
  internal           = false
  load_balancer_type = "application"

  security_groups = [
    aws_security_group.alb_sg.id
  ]

  subnets = [
    aws_subnet.public_1.id,
    aws_subnet.public_2.id
  ]

  tags = {
    Name = "cure-alb"
  }
}

resource "aws_lb_target_group" "tg" {
  name     = "cure-tg"
  port     = 80
  protocol = "HTTP"

  vpc_id = aws_vpc.main.id

  health_check {
    enabled             = true
    healthy_threshold   = 2
    unhealthy_threshold = 2
    interval            = 30
    timeout             = 5
    path                = "/health"
    matcher             = "200"
  }

  tags = {
    Name = "cure-target-group"
  }
}

# ATTACH cure-app

resource "aws_lb_target_group_attachment" "app" {
  target_group_arn = aws_lb_target_group.tg.arn
  target_id        = aws_instance.app.id
  port             = 80
}

# ATTACH cure-app-2

resource "aws_lb_target_group_attachment" "app2" {
  target_group_arn = aws_lb_target_group.tg.arn
  target_id        = aws_instance.app2.id
  port             = 80
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}