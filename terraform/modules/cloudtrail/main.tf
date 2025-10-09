resource "aws_cloudtrail" "main" {
  name                          = var.trail_name
  s3_bucket_name                = var.s3_bucket_name
  s3_key_prefix                 = var.s3_key_prefix
  include_global_service_events = var.include_global_service_events
}

resource "aws_cloudtrail_event_data_store" "main" {
  name = var.trail_name
}

resource "aws_kinesis_firehose_delivery_stream" "this" {
  name        = var.stream_name
  destination = "extended_s3"
  extended_s3_configuration {
    role_arn = var.role_arn
    bucket_arn = var.bucket_arn
    buffering_size = var.buffering_size
    buffering_interval = var.buffering_interval
    compression_format = "UNCOMPRESSED"
  }
}


# Compare this snippet from aws-monit-logging-pipeline/modules/cloudtrail/variable.tf:
# variable "trail_name" {
#   description = "The name of the CloudTrail trail"
#   type        = string
# }