variable "log_group_name" {
    description = "The name of the CloudWatch log group"
    type        = string
    default     = "cicd-cloudwatch-log-group"
}

variable "alarm_name" {
    description = "The name of the CloudWatch metric alarm"
    type        = string
    default     = "cicd-cloudwatch-alarm"
}

variable "metric_name" {
    description = "The name of the CloudWatch metric to monitor"
    type        = string
    default     = "CPUUtilization"
}

variable "stream_name" {
    description = "The name of the Kinesis Firehose delivery stream"
    type        = string
    default     = "cicd-kinesis-firehose"
}


variable "firehose_role_arn" {
    description = "The ARN of the IAM role for Kinesis Firehose"
    type        = string
    default     = "arn:aws:iam::123456789012:role/firehose_delivery_role"
}

variable "firehose_bucket_arn" {
    description = "The ARN of the S3 bucket for Kinesis Firehose"
    type        = string
#    default     = "arn:aws:s3:::cicd-kinesis-firehose-bucket"
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
    default     = "GZIP"
}

variable "s3_bucket_name" {
    description = "The name of the S3 bucket where Kinesis Firehose will deliver data"
    type        = string
    default     = "ec2-shutdown-lambda-bucket"
}

variable "s3_prefix" {
    description = "The prefix for the S3 key where Kinesis Firehose will deliver data"
    type        = string
    default     = "kinesis-firehose/"
}

variable "s3_bucket_arn" {
    description = "The ARN of the S3 bucket where Kinesis Firehose will deliver data"
    type        = string
    default     = "arn:aws:s3::615299732970:ec2-shutdown-lambda-bucket"
}

