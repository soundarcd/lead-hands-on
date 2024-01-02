output "dashboard_arn" {
  description = "CloudWatch Dashboard ARN"
  value       = aws_cloudwatch_dashboard.ec2_metrics_dashboard.arn
}

# Define other output variables as needed

