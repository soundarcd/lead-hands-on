output "instance_id" {
  description = "EC2 instance ID"
  value       = aws_instance.cloudwatch_agent.id
}

# Define other output variables as needed

