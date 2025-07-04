resource "aws_sqs_queue" "example" {
  name = var.queue_name
}