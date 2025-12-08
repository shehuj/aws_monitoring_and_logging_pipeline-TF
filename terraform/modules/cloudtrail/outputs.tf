output "trail_name" {
  description = "The name of the CloudTrail"
  value       = aws_cloudtrail.main.name
}

output "trail_arn" {
  description = "The ARN of the CloudTrail"
  value       = aws_cloudtrail.main.arn
}