variable "aws_kinesis_firehose_delivery_stream_name" {
  description = "The name of the Kinesis Firehose delivery stream"
  type        = string
  default     = "aws-monit-logging-pipeline"
}

variable "stream_name" {
    description = "The name of the Kinesis Firehose delivery stream"
    type        = string
    default     = "aws-monit-logging-pipeline"
}

variable "role_arn" {
    description = "The ARN of the IAM role that Kinesis Firehose will assume to deliver data to the destination"
    type        = string
    default     = "arn:aws:iam::615299732970:role/firehose_delivery_role"
}

variable "bucket_arn" {
    description = "The ARN of the S3 bucket where Kinesis Firehose will deliver data"
    type        = string
    default     = "arn:aws:s3:::aws-monit-logging-pipeline"
}

variable "buffering_size" {
    description = "The size in MB to buffer before delivering data to the destination"
    type        = number
    default     = 5
}

variable "buffering_interval" {
    description = "The time in seconds to buffer before delivering data to the destination"
    type        = number
    default     = 300
}

variable "compression_format" {
    description = "The compression format to use for the data delivered to the destination"
    type        = string
    default     = "UNCOMPRESSED"
}

variable "s3_key_prefix" {
    description = "The prefix for the S3 key where Kinesis Firehose will deliver data"
    type        = string
    default     = "kinesis-firehose/"
}

variable "s3_bucket_name" {
    description = "The name of the S3 bucket where Kinesis Firehose will deliver data"
    type        = string
    default     = "aws-monit-logging-pipeline"
}
