variable "topic_name" {
  description = "Name for the SNS topic"
  type        = string
}

variable "email_subscriptions" {
  description = "List of email addresses to subscribe to SNS topic"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Tags to apply to SNS topic"
  type        = map(string)
  default     = {}
}