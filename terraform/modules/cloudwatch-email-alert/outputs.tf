output "sns_topic_arn" {
  description = "SNS Topic ARN for email notifications"
  value       = aws_sns_topic.email_notifications.arn
}

output "cloudwatch_alarm_name" {
  description = "CloudWatch Alarm Name"
  value       = aws_cloudwatch_metric_alarm.example_alarm.alarm_name
}

# Define other output variables as needed

