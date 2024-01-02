output "role_arn" {
  description = "IAM Role ARN"
  value       = aws_iam_role.cloudwatch_agent_role.arn
}

# Define other output variables as needed

