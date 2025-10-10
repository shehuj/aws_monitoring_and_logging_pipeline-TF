 variable "topic_name" {
    description = "Name for the SNS topic"
    type        = string
    default     = "aws-monit-logging-pipeline-sns"
 }

 variable "subscription_endpoint" {
    description = "Endpoint for the SNS subscription"
    type        = string
    default     = "shehuj35@gmail.com"
 }