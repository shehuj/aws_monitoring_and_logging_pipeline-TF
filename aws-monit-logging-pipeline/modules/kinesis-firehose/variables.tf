variable "aws_kinesis_firehose_delivery_stream_name" {
  description = "The name of the Kinesis Firehose delivery stream"
  type        = string
  default     = "aws-monit-logging-pipeline"
  
}

variable "stream_name" {
    description = "The name of the Kinesis Firehose delivery stream"
    type        = string
    default     = "aws-monit-logging-pipeline"
  
}