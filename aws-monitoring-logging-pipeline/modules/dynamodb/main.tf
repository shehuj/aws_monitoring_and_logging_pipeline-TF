resource "aws_dynamodb_table" "this" {
  name           = var.table_name
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = var.hash_key

  attribute {
    name = var.hash_key
    type = "S"
  }
}

resource "aws_kinesis_firehose_delivery_stream" "this" {
  name        = var.stream_name
  destination = "extended_s3"
  extended_s3_configuration {
    role_arn = var.role_arn
    bucket_arn = var.bucket_arn
    buffering_size = var.buffering_size
    buffering_interval = var.buffering_interval
    compression_format = var.compression_format 
  }
}