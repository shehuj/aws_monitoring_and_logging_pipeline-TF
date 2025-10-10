variable "trail_name" {
  type = string
  default = "cicd-cloudtrail"
}

variable "s3_bucket_name" {
  type = string
}

variable "s3_key_prefix" {
  type    = string
  default = "cloudtrail"
}

variable "include_global_service_events" {
  type    = bool
  default = true
}
 variable "trail_arn" {
  type = string
  default = "arn:aws:cloudtrail:us-east-1:615299732970:trail/cicd-cloudtrail"
}

variable "trail_id" {
  type = string
  default = "cicd-cloudtrail"
}

variable "stream_name" {
  type    = string
  default = "cicd-kinesis-firehose"
}

variable "role_arn" {
  type = string
#  default = "arn:aws:iam::615299732970:role/firehose_delivery_role"
}

variable "bucket_arn" {
  type = string
#  default = "arn:aws:s3:::aws-monit-logging-pipeline"
}

variable "buffering_size" {
  type    = number
  default = 5 # Size in MB to buffer before delivering data to the destination
}

variable "buffering_interval" {
  type    = number
  default = 300 # Time in seconds to buffer before delivering data to the destination
}

variable "compression_format" {
  type    = string
  default = "UNCOMPRESSED" # Compression format to use for the data delivered to the destination
}