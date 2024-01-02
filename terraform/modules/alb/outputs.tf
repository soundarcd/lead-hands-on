output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = aws_lb.alb.dns_name
}

output "alb_arn" {
  description = "ARN of the Application Load Balancer"
  value       = aws_lb.alb.arn
}


output "asg_arn" {
  value = aws_autoscaling_group.asg.arn
  description = "The ARN of the Auto Scaling Group"
}

// Add other outputs as needed

