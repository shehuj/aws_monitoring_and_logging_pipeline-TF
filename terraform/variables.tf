# AWS Region
variable "aws_region" {
  description = "AWS region where resources will be created"
  type        = string
  default     = "us-east-1"
}

# Project and Environment Configuration
variable "project_name" {
  description = "Project name used for naming resources"
  type        = string
  default     = "monitoring-pipeline"
}

variable "environment" {
  description = "Environment (dev, staging, prod)"
  type        = string
  default     = "prod"
}

# Naming prefix for resource uniqueness
variable "naming_prefix" {
  description = "Prefix for resource names to ensure uniqueness"
  type        = string
  default     = "aws-mon-log"
}

# AWS Account ID (for IAM and resource references)
variable "aws_account_id" {
  description = "AWS Account ID"
  type        = string
  default     = "615299732970"  # If empty, will be fetched from the provider
}

# S3 Configuration
variable "s3_bucket_name" {
  description = "Name for the centralized logging S3 bucket (must be globally unique)"
  type        = string
  default     = ""  # If empty, will be generated from naming_prefix
}

variable "enable_s3_lifecycle" {
  description = "Enable S3 lifecycle rules for log retention"
  type        = bool
  default     = true
}

# CloudTrail Configuration
variable "cloudtrail_name" {
  description = "Name for the CloudTrail"
  type        = string
  default     = ""  # If empty, will be generated
}

variable "enable_cloudtrail_encryption" {
  description = "Enable CloudTrail log encryption"
  type        = bool
  default     = true
}

# CloudWatch Configuration
variable "cloudwatch_log_group_name" {
  description = "Name for the CloudWatch log group"
  type        = string
  default     = ""  # If empty, will be generated
}

variable "cloudwatch_retention_days" {
  description = "CloudWatch Logs retention in days"
  type        = number
  default     = 30
}

# SNS Configuration
variable "sns_topic_name" {
  description = "Name for the SNS topic"
  type        = string
  default     = ""  # If empty, will be generated
}

variable "sns_email_subscriptions" {
  description = "List of email addresses to subscribe to SNS alerts"
  type        = list(string)
  default     = []
}

# SQS Configuration
variable "sqs_queue_name" {
  description = "Name for the SQS queue"
  type        = string
  default     = ""  # If empty, will be generated
}

# DynamoDB Configuration
variable "dynamodb_table_name" {
  description = "Name for the DynamoDB table"
  type        = string
  default     = ""  # If empty, will be generated
}

# Kinesis Firehose Configuration
variable "kinesis_firehose_name" {
  description = "Name for the Kinesis Firehose delivery stream"
  type        = string
  default     = ""  # If empty, will be generated
}

# Common Tags
variable "tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default = {
    Terraform   = "true"
    Project     = "monitoring-pipeline"
    ManagedBy   = "Terraform"
  }
}

# Feature Flags
variable "enable_cloudtrail" {
  description = "Enable CloudTrail module"
  type        = bool
  default     = true
}

variable "enable_cloudwatch" {
  description = "Enable CloudWatch module"
  type        = bool
  default     = true
}

variable "enable_sns" {
  description = "Enable SNS module"
  type        = bool
  default     = true
}

variable "enable_sqs" {
  description = "Enable SQS module"
  type        = bool
  default     = true
}

variable "enable_kinesis_firehose" {
  description = "Enable Kinesis Firehose module"
  type        = bool
  default     = true
}

variable "enable_dynamodb" {
  description = "Enable DynamoDB module"
  type        = bool
  default     = true
}
