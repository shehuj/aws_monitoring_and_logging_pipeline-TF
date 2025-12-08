resource "aws_cloudwatch_log_group" "this" {
  name              = var.log_group_name
  retention_in_days = var.retention_days

  tags = var.tags
}

resource "aws_cloudwatch_metric_alarm" "this" {
  count = var.create_alarm ? 1 : 0

  alarm_name          = var.alarm_name
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = var.metric_name
  namespace           = "AWS/EC2"
  period              = "300"
  statistic           = "Average"
  threshold           = "80"
  alarm_description   = "This metric monitors ec2 cpu utilization"

  tags = var.tags
} 