resource "aws_sns_topic" "example" {
  name = var.topic_name
}

resource "aws_sns_topic_subscription" "example" {
  topic_arn = aws_sns_topic.example.arn
  protocol  = "email"
  endpoint  = var.subscription_endpoint
}