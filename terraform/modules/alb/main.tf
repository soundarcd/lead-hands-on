resource "aws_lb" "alb" {
  name               = var.alb_name
  internal           = var.internal
  load_balancer_type = "application"
  security_groups    = var.security_groups
  subnets            = var.subnets

  enable_deletion_protection = var.enable_deletion_protection


enable_http2 = true

}
resource "aws_lb_listener" "listener_80" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}

resource "aws_lb_target_group" "tg" {
  name     = var.targetgroup
  port     = "3000"
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_listener" "listener_443" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "443"
  protocol          = "HTTP"
#  ssl_policy        = "ELBSecurityPolicy-2016-08"
#  certificate_arn   = "arn:aws:acm:region:account-id:certificate/certificate-id" # Replace with your SSL certificate ARN
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}


resource "aws_security_group" "instance_sg" {
  name        = var.instance_security_group_name
  description = "Security group for instance"
  vpc_id      = var.vpc_id
  // Allow inbound traffic on port 80 for HTTP
  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

}

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"           # -1 indicates all protocols
    cidr_blocks = ["0.0.0.0/0"]  # Allow all outbound traffic
  }


}

resource "aws_launch_configuration" "launching_configuration" {
  #image_id        = "ami-0ce2cb35386fc22e9"  # Ubuntu 20.04 LTS AMI ID
  image_id        = var.image_id
  instance_type   = var.instance_type
  key_name      =   var.key_name
  security_groups   = [aws_security_group.instance_sg.id]
  user_data       = var.user_data
}

resource "aws_autoscaling_group" "asg" {
  launch_configuration = aws_launch_configuration.launching_configuration.name
  name                      = var.autoscalinggroupname
  min_size              = var.min_size
  max_size              = var.max_size
  desired_capacity      = var.desired_capacity
  vpc_zone_identifier = var.vpc_zone_identifier
  target_group_arns = ["${aws_lb_target_group.tg.arn}"]
  depends_on = [aws_launch_configuration.launching_configuration]
}





