resource "aws_cloudtrail" "main" {
  name                          = var.trail_name
  s3_bucket_name                = var.s3_bucket_name
  s3_key_prefix                 = var.s3_key_prefix
  include_global_service_events = var.include_global_service_events
}

# Compare this snippet from aws-monit-logging-pipeline/modules/cloudtrail/variable.tf:
# variable "trail_name" {
#   description = "The name of the CloudTrail trail"
#   type        = string
# }