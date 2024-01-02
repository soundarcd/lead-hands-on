# ec2-instance-module/main.tf

resource "aws_launch_configuration" "example_lc" {
  name_prefix   = "example-lc-"
  image_id      = var.ami_id
  instance_type = var.instance_type

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World!" > index.html
              nohup python -m SimpleHTTPServer 8080 &
              EOF
}

resource "aws_autoscaling_group" "example_asg" {
  launch_configuration = aws_launch_configuration.example_lc.name
  availability_zones   = var.availability_zones
  min_size             = 2
  max_size             = 10
  desired_capacity     = 2


  # ...
}

