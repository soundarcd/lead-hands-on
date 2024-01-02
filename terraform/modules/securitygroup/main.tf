resource "aws_security_group" "alb_sg" {
  name        = var.security_group_name
  description = "Security group for ALB"
  vpc_id      = var.vpc_id  # Assuming you'll pass VPC ID as a variable

  // Allow inbound traffic on port 80 for HTTP
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  // ... add other ingress/egress rules as needed
}


