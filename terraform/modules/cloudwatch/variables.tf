variable "log_group_name" {
  description = "The name of the CloudWatch log group"
  type        = string
}

variable "retention_days" {
  description = "Number of days to retain CloudWatch logs"
  type        = number
  default     = 30
}

variable "create_alarm" {
  description = "Whether to create a CloudWatch metric alarm"
  type        = bool
  default     = false
}

variable "alarm_name" {
  description = "The name of the CloudWatch metric alarm"
  type        = string
  default     = "monitoring-alarm"
}

variable "metric_name" {
  description = "The name of the CloudWatch metric to monitor"
  type        = string
  default     = "CPUUtilization"
}

variable "tags" {
  description = "Tags to apply to CloudWatch resources"
  type        = map(string)
  default     = {}
}

