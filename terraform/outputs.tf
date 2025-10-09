output "s3_bucket_name" {
  value = module.s3.bucket_name
}
output "cloudtrail_arn" {
  value = module.cloudtrail.trail_arn
}
output "cloudwatch_log_group_name" {
  value = module.cloudwatch.log_group_name
}
output "sns_topic_arn" {
  value = module.sns.topic_arn
}
output "sqs_queue_url" {
  value = module.sqs.queue_url
}
output "kinesis_firehose_stream_name" {
  value = module.kinesis_firehose.stream_name
}
output "dynamodb_table_name" {
  value = module.dynamodb.table_name
}
output "dynamodb_table_arn" {
  value = module.dynamodb.table_arn
}
output "dynamodb_table_stream_arn" {
  value = module.dynamodb.table_stream_arn
}