resource "aws_cloudwatch_log_group" "this" {
  name = var.log_group_name
}

resource "aws_cloudwatch_metric_alarm" "this" {
  alarm_name          = var.alarm_name
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "300"
  statistic           = "Average"
  threshold           = "80"
  alarm_description   = "This metric monitors ec2 cpu utilization"
}

resource "aws_kinesis_firehose_delivery_stream" "this" {
  name        = var.stream_name
  destination = "extended_s3"
  extended_s3_configuration {
    role_arn           = var.firehose_role_arn
    bucket_arn         = var.s3_bucket_arn
    prefix             = var.s3_prefix
    buffering_interval = 300
    buffering_size     = 5
    compression_format = "GZIP"
  }
} 