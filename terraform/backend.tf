# Terraform Backend Configuration
# Stores state in S3 with DynamoDB locking for team collaboration

terraform {
  backend "s3" {
    bucket         = "ec2-shutdown-lambda-bucket"  # Change this to your state bucket
    key            = "monitoring-pipeline/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "dyning_table"  # Change this to your lock table

    # Optional: Enable versioning on the state bucket for state history
    ## versioning = true
  }
}
