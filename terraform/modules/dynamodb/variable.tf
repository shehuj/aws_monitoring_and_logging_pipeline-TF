variable "table_name" {
    description = "The name of the DynamoDB table"
    type        = string
    default     = "cicd-dynamodb-table"
}

variable "hash_key" {
    description = "The hash key for the DynamoDB table"
    type        = string
    default     = "id"
}

variable "stream_name" {
    description = "The name of the Kinesis Firehose delivery stream"
    type        = string
    default     = "cicd-kinesis-firehose"
}

variable "role_arn" {
    description = "The ARN of the IAM role for Kinesis Firehose"
    type        = string
    default     = "arn:aws:iam::615299732970:role/firehose_delivery_role"
}

variable "bucket_arn" {
    description = "The ARN of the S3 bucket for Kinesis Firehose"
    type        = string
    default     = "arn:aws:s3:::cicd-kinesis-firehose-bucket"
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