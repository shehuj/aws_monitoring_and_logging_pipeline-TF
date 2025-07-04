variable "queue_name" {
  description = "Name for the SQS queue"
  type        = string
  default     = "aws-monit-logging-pipeline-sqs"
}