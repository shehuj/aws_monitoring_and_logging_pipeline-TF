output "trail_name" {
  description = "The name of the Kinesis Firehose delivery stream"
  value       = aws_kinesis_firehose_delivery_stream.this.name
  
}
output "trail_arn" {
  description = "The ARN of the Kinesis Firehose delivery stream"
  value       = aws_kinesis_firehose_delivery_stream.this.arn
}