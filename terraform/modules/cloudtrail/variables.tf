variable "trail_name" {
  description = "Name of the CloudTrail"
  type        = string
}

variable "s3_bucket_name" {
  description = "Name of the S3 bucket where CloudTrail logs will be stored"
  type        = string
}

variable "tags" {
  description = "Tags to apply to CloudTrail"
  type        = map(string)
  default     = {}
}
