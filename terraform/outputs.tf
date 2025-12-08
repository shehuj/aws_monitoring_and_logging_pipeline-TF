# S3 Outputs (always created)
output "s3_bucket_name" {
  description = "The name of the S3 logging bucket"
  value       = module.s3.bucket_name
}

output "s3_bucket_arn" {
  description = "The ARN of the S3 logging bucket"
  value       = module.s3.bucket_arn
}

# CloudTrail Outputs (conditional)
output "cloudtrail_arn" {
  description = "The ARN of the CloudTrail"
  value       = var.enable_cloudtrail ? module.cloudtrail[0].trail_arn : null
}

output "cloudtrail_name" {
  description = "The name of the CloudTrail"
  value       = var.enable_cloudtrail ? module.cloudtrail[0].trail_name : null
}

# CloudWatch Outputs (conditional)
output "cloudwatch_log_group_name" {
  description = "The name of the CloudWatch log group"
  value       = var.enable_cloudwatch ? module.cloudwatch[0].log_group_name : null
}

output "cloudwatch_log_group_arn" {
  description = "The ARN of the CloudWatch log group"
  value       = var.enable_cloudwatch ? module.cloudwatch[0].log_group_arn : null
}

# SNS Outputs (conditional)
output "sns_topic_arn" {
  description = "The ARN of the SNS topic"
  value       = var.enable_sns ? module.sns[0].topic_arn : null
}

# SQS Outputs (conditional)
output "sqs_queue_url" {
  description = "The URL of the SQS queue"
  value       = var.enable_sqs ? module.sqs[0].queue_url : null
}

output "sqs_queue_arn" {
  description = "The ARN of the SQS queue"
  value       = var.enable_sqs ? module.sqs[0].arn : null
}

# Kinesis Firehose Outputs (conditional)
output "kinesis_firehose_stream_name" {
  description = "The name of the Kinesis Firehose delivery stream"
  value       = var.enable_kinesis_firehose ? module.kinesis_firehose[0].stream_name : null
}

# DynamoDB Outputs (conditional)
output "dynamodb_table_name" {
  description = "The name of the DynamoDB table"
  value       = var.enable_dynamodb ? module.dynamodb[0].table_name : null
}

output "dynamodb_table_arn" {
  description = "The ARN of the DynamoDB table"
  value       = var.enable_dynamodb ? module.dynamodb[0].table_arn : null
}

output "dynamodb_table_stream_arn" {
  description = "The ARN of the DynamoDB table stream"
  value       = var.enable_dynamodb ? module.dynamodb[0].table_stream_arn : null
}