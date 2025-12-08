variable "bucket_name" {
  description = "Name for the logging bucket"
  type        = string
}

variable "tags" {
  description = "Tags to apply to S3 bucket"
  type        = map(string)
  default     = {}
}