variable "queue_name" {
  description = "Name for the SQS queue"
  type        = string
}

variable "tags" {
  description = "Tags to apply to SQS queue"
  type        = map(string)
  default     = {}
}