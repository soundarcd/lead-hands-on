variable "topic_name" {
  description = "SNS topic name for email notifications"
  type        = string
}

variable "email_address" {
  description = "Email address for SNS notifications"
  type        = string
}

variable "alarm_name" {
  description = "CloudWatch Alarm name"
  type        = string
}

# Define other input variables as needed (e.g., evaluation_periods, metric_name, namespace, etc.)

