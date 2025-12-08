# AWS Provider Configuration
provider "aws" {
  region = var.aws_region
}

# Local values for resource naming
locals {
  # Generate unique names if not provided
  s3_bucket_name          = var.s3_bucket_name != "" ? var.s3_bucket_name : "${var.naming_prefix}-${var.environment}-logs-${var.aws_account_id}"
  cloudtrail_name         = var.cloudtrail_name != "" ? var.cloudtrail_name : "${var.naming_prefix}-${var.environment}-trail"
  cloudwatch_log_group    = var.cloudwatch_log_group_name != "" ? var.cloudwatch_log_group_name : "${var.naming_prefix}-${var.environment}-logs"
  sns_topic_name          = var.sns_topic_name != "" ? var.sns_topic_name : "${var.naming_prefix}-${var.environment}-alerts"
  sqs_queue_name          = var.sqs_queue_name != "" ? var.sqs_queue_name : "${var.naming_prefix}-${var.environment}-queue"
  dynamodb_table_name     = var.dynamodb_table_name != "" ? var.dynamodb_table_name : "${var.naming_prefix}-${var.environment}-tracking"
  kinesis_firehose_name   = var.kinesis_firehose_name != "" ? var.kinesis_firehose_name : "${var.naming_prefix}-${var.environment}-stream"

  # Common tags to apply to all resources
  common_tags = merge(
    var.tags,
    {
      Environment = var.environment
      Project     = var.project_name
      ManagedBy   = "Terraform"
    }
  )
}

# S3 Module - Centralized Logging Bucket
module "s3" {
  source      = "./modules/s3"
  bucket_name = local.s3_bucket_name
  tags        = local.common_tags
}

# CloudTrail Module - API Audit Logging
module "cloudtrail" {
  count = var.enable_cloudtrail ? 1 : 0

  source         = "./modules/cloudtrail"
  trail_name     = local.cloudtrail_name
  s3_bucket_name = module.s3.bucket_name
  tags           = local.common_tags
}

# CloudWatch Module - Logs and Metrics
module "cloudwatch" {
  count = var.enable_cloudwatch ? 1 : 0

  source             = "./modules/cloudwatch"
  log_group_name     = local.cloudwatch_log_group
  retention_days     = var.cloudwatch_retention_days
  tags               = local.common_tags
}

# SNS Module - Alerting and Notifications
module "sns" {
  count = var.enable_sns ? 1 : 0

  source              = "./modules/sns"
  topic_name          = local.sns_topic_name
  email_subscriptions = var.sns_email_subscriptions
  tags                = local.common_tags
}

# SQS Module - Message Queuing
module "sqs" {
  count = var.enable_sqs ? 1 : 0

  source     = "./modules/sqs"
  queue_name = local.sqs_queue_name
  tags       = local.common_tags
}

# Kinesis Firehose Module - Log Streaming
module "kinesis_firehose" {
  count = var.enable_kinesis_firehose ? 1 : 0

  source            = "./modules/kinesis-firehose"
  firehose_name     = local.kinesis_firehose_name
  s3_bucket_arn     = module.s3.bucket_arn
  s3_bucket_name    = module.s3.bucket_name
  tags              = local.common_tags
}

# DynamoDB Module - State and Tracking
module "dynamodb" {
  count = var.enable_dynamodb ? 1 : 0

  source     = "./modules/dynamodb"
  table_name = local.dynamodb_table_name
  tags       = local.common_tags
}
