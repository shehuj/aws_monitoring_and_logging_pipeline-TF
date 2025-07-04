provider "aws" {
  region = var.aws_region
}

module "s3" {
  source      = "./modules/s3"
  bucket_name = "centralized-logging-bucket"
}

module "cloudtrail" {
  source         = "./modules/cloudtrail"
  trail_name     = "global-trail"
  s3_bucket_name = module.s3.bucket_name
}

module "cloudwatch" {
  source = "./modules/cloudwatch"
}

module "sns" {
  source = "./modules/sns"
}

module "sqs" {
  source = "./modules/sqs"
}

module "kinesis_firehose" {
  source = "./modules/kinesis-firehose"
}

module "dynamodb" {
  source = "./modules/dynamodb"
}

# Outputs
# Repeat for remaining modules: cloudwatch, sns, sqs, kinesis-firehose, dynamodb