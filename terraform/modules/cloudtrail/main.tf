resource "aws_cloudtrail" "main" {
  name                          = var.trail_name
  s3_bucket_name                = var.s3_bucket_name
  include_global_service_events = true
  enable_logging                = true
  is_multi_region_trail         = true
  enable_log_file_validation    = true

  tags = var.tags
}