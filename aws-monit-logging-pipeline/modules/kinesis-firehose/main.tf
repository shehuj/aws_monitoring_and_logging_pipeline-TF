resource "aws_kinesis_firehose_delivery_stream" "example" {
  name        = var.stream_name
  destination = "extended_s3"

}
resource "aws_kinesis_firehose_delivery_stream" "this" {
  name        = var.stream_name
  destination = "extended_s3"
}
