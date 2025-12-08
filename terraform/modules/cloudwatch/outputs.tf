output "log_group_name" {
  description = "The name of the CloudWatch log group"
  value       = aws_cloudwatch_log_group.this.name
}

output "log_group_arn" {
  description = "The ARN of the CloudWatch log group"
  value       = aws_cloudwatch_log_group.this.arn
}

output "alarm_arn" {
  description = "The ARN of the CloudWatch alarm (if created)"
  value       = length(aws_cloudwatch_metric_alarm.this) > 0 ? aws_cloudwatch_metric_alarm.this[0].arn : null
}

