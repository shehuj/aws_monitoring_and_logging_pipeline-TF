# Terraform Backend Configuration
# Stores state in S3 with DynamoDB locking for team collaboration
#
# IMPORTANT: Update the values below before running terraform init
#
# To use this backend:
# 1. Create an S3 bucket for state storage with versioning enabled
# 2. Create a DynamoDB table with primary key "LockID" (String) for state locking
# 3. Update the bucket, region, and dynamodb_table values below
# 4. Run: terraform init
#
# Alternatively, comment out this entire block to use local state storage

terraform {
  backend "s3" {
    # REQUIRED: Replace with your S3 bucket name for state storage
    bucket = "ec2-shutdown-lambda-bucket"

    # State file path within the bucket
    key = "monitoring-pipeline/terraform.tfstate"

    # REQUIRED: Replace with your AWS region
    region = "us-east-1"

    # Enable encryption for state file
    encrypt = true

    # REQUIRED: Replace with your DynamoDB table name for state locking
    # Table must have a primary key named "LockID" with type String
    dynamodb_table = "dyning_table"
  }
}
