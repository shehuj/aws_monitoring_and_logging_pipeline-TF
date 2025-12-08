variable "firehose_name" {
  description = "The name of the Kinesis Firehose delivery stream"
  type        = string
}

variable "s3_bucket_arn" {
  description = "The ARN of the S3 bucket where Kinesis Firehose will deliver data"
  type        = string
}

variable "s3_bucket_name" {
  description = "The name of the S3 bucket where Kinesis Firehose will deliver data"
  type        = string
}

variable "tags" {
  description = "Tags to apply to Kinesis Firehose resources"
  type        = map(string)
  default     = {}
}
