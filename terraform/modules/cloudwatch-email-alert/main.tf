resource "aws_sns_topic" "email_notifications" {
  name = var.topic_name
}

resource "aws_sns_topic_subscription" "email_subscription" {
  topic_arn = aws_sns_topic.email_notifications.arn
  protocol  = "email"
  endpoint  = var.email_address
}

resource "aws_cloudwatch_metric_alarm" "example_alarm" {
  alarm_name          = var.alarm_name
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = var.evaluation_periods
  metric_name         = var.metric_name
  namespace           = var.namespace
  period              = var.period
  statistic           = var.statistic
  threshold           = var.threshold
  alarm_description   = var.alarm_description
  alarm_actions       = [aws_sns_topic.email_notifications.arn]

  dimensions = var.dimensions
}

