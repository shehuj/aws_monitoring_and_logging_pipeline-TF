# AWS Monitoring & Logging Pipeline (Terraform)

A production-ready, modular Terraform infrastructure for deploying a comprehensive AWS monitoring and logging pipeline. This solution provides centralized logging, audit trails, real-time alerting, and log streaming capabilities using AWS native services.

## Table of Contents

- [Overview](#overview)
- [Architecture](#architecture)
- [Features](#features)
- [Prerequisites](#prerequisites)
- [Repository Structure](#repository-structure)
- [Quick Start](#quick-start)
- [Configuration](#configuration)
- [Module Documentation](#module-documentation)
- [Outputs](#outputs)
- [Security Considerations](#security-considerations)
- [Cost Optimization](#cost-optimization)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)

## Overview

This Terraform project deploys a complete monitoring and logging infrastructure on AWS, featuring:

- **CloudTrail** for API audit logging across all AWS services
- **S3** for centralized, durable log storage with lifecycle management
- **CloudWatch** for real-time log aggregation, metrics, and alarms
- **SNS** for flexible notification delivery
- **SQS** for decoupled, asynchronous message processing
- **Kinesis Firehose** for real-time log streaming and delivery
- **DynamoDB** for state tracking and metadata storage

All infrastructure is managed as code with Terraform, enabling version control, peer review, and reproducible deployments.

## Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                         AWS Account                              │
│                                                                  │
│  ┌──────────────┐     ┌─────────────┐     ┌─────────────────┐ │
│  │  CloudTrail  │────▶│     S3      │◀────│ Kinesis Firehose│ │
│  │  (API Logs)  │     │  (Logging)  │     │  (Streaming)    │ │
│  └──────────────┘     └─────────────┘     └─────────────────┘ │
│         │                    │                                  │
│         │                    │                                  │
│         ▼                    ▼                                  │
│  ┌──────────────────────────────────┐                          │
│  │         CloudWatch               │                          │
│  │    (Logs, Metrics, Alarms)       │                          │
│  └──────────────────────────────────┘                          │
│                  │                                              │
│                  ▼                                              │
│         ┌────────────────┐                                      │
│         │      SNS       │──▶ Email/SMS Notifications          │
│         │   (Alerting)   │                                      │
│         └────────────────┘                                      │
│                  │                                              │
│                  ▼                                              │
│         ┌────────────────┐                                      │
│         │      SQS       │──▶ Application Processing           │
│         │   (Queuing)    │                                      │
│         └────────────────┘                                      │
│                                                                  │
│  ┌──────────────────────────────────┐                          │
│  │         DynamoDB                 │                          │
│  │  (State & Metadata Tracking)     │                          │
│  └──────────────────────────────────┘                          │
└─────────────────────────────────────────────────────────────────┘
```

## Features

### Core Capabilities

✅ **Modular Design** - Enable/disable components via feature flags
✅ **Multi-Region Support** - CloudTrail configured for multi-region trails
✅ **Encryption** - S3 encryption at rest, state file encryption
✅ **Log Lifecycle Management** - Automatic transition to cheaper storage classes
✅ **Flexible Alerting** - Support for multiple SNS email subscriptions
✅ **IAM Best Practices** - Least privilege IAM roles with inline policies
✅ **Tag Management** - Consistent tagging across all resources
✅ **State Management** - Remote state with locking via S3 + DynamoDB

### Security Features

- S3 bucket public access blocking
- CloudTrail log file validation
- Server-side encryption (SSE-S3)
- Proper S3 bucket policies for CloudTrail
- IAM roles with minimal required permissions

## Prerequisites

Before deploying this infrastructure, ensure you have:

1. **AWS Account** with appropriate permissions to create:
   - S3 buckets
   - CloudTrail trails
   - CloudWatch log groups and alarms
   - SNS topics and subscriptions
   - SQS queues
   - Kinesis Firehose delivery streams
   - DynamoDB tables
   - IAM roles and policies

2. **AWS CLI** configured with valid credentials:
   ```bash
   aws configure
   ```

3. **Terraform** version 1.0 or later:
   ```bash
   terraform version
   ```

4. **AWS Account ID** - You'll need this for configuration

## Repository Structure

```
.
├── README.md                           # This file
├── terraform/
│   ├── main.tf                         # Main infrastructure configuration
│   ├── variables.tf                    # Input variables
│   ├── outputs.tf                      # Output values
│   ├── versions.tf                     # Terraform & provider versions
│   ├── backend.tf                      # Remote state configuration
│   ├── terraform.tfvars.example        # Example variables file
│   └── modules/
│       ├── s3/                         # S3 logging bucket
│       │   ├── main.tf
│       │   ├── variables.tf
│       │   └── outputs.tf
│       ├── cloudtrail/                 # CloudTrail audit logging
│       │   ├── main.tf
│       │   ├── variables.tf
│       │   └── outputs.tf
│       ├── cloudwatch/                 # CloudWatch logs & alarms
│       │   ├── main.tf
│       │   ├── variables.tf
│       │   └── outputs.tf
│       ├── sns/                        # SNS notifications
│       │   ├── main.tf
│       │   ├── variables.tf
│       │   └── outputs.tf
│       ├── sqs/                        # SQS message queuing
│       │   ├── main.tf
│       │   ├── variables.tf
│       │   └── outputs.tf
│       ├── kinesis-firehose/           # Kinesis Firehose streaming
│       │   ├── main.tf
│       │   ├── variables.tf
│       │   └── outputs.tf
│       └── dynamodb/                   # DynamoDB state tracking
│           ├── main.tf
│           ├── variables.tf
│           └── outputs.tf
└── .github/
    └── workflows/                      # GitHub Actions CI/CD (optional)
```

## Quick Start

### 1. Clone the Repository

```bash
git clone https://github.com/shehuj/aws_monitoring_and_logging_pipeline-TF.git
cd aws_monitoring_and_logging_pipeline-TF/terraform
```

### 2. Configure Backend (Optional)

If you want to use remote state storage:

1. Create an S3 bucket for Terraform state:
   ```bash
   aws s3 mb s3://your-terraform-state-bucket --region us-east-1
   aws s3api put-bucket-versioning \
     --bucket your-terraform-state-bucket \
     --versioning-configuration Status=Enabled
   ```

2. Create a DynamoDB table for state locking:
   ```bash
   aws dynamodb create-table \
     --table-name terraform-state-lock \
     --attribute-definitions AttributeName=LockID,AttributeType=S \
     --key-schema AttributeName=LockID,KeyType=HASH \
     --billing-mode PAY_PER_REQUEST \
     --region us-east-1
   ```

3. Update `backend.tf` with your bucket name and table name.

**Alternatively**, comment out the entire `backend.tf` file to use local state storage.

### 3. Create Configuration File

Copy the example configuration and customize it:

```bash
cp terraform.tfvars.example terraform.tfvars
```

Edit `terraform.tfvars` with your values:

```hcl
# Required
aws_region     = "us-east-1"
aws_account_id = "123456789012"  # Your AWS account ID

# Project Configuration
project_name   = "monitoring-pipeline"
environment    = "prod"
naming_prefix  = "my-company"

# Optional: Custom resource names
s3_bucket_name = "my-company-prod-logs-123456789012"

# Optional: SNS Email Notifications
sns_email_subscriptions = [
  "devops@example.com",
  "alerts@example.com"
]

# Optional: Feature Flags (all default to true)
enable_cloudtrail        = true
enable_cloudwatch        = true
enable_sns               = true
enable_sqs               = true
enable_kinesis_firehose  = true
enable_dynamodb          = true

# Optional: CloudWatch Configuration
cloudwatch_retention_days = 30

# Optional: Tags
tags = {
  Owner       = "DevOps Team"
  CostCenter  = "Engineering"
  Compliance  = "Required"
}
```

### 4. Initialize Terraform

```bash
terraform init
```

### 5. Review the Plan

```bash
terraform plan
```

Review the resources that will be created. Ensure everything looks correct.

### 6. Deploy the Infrastructure

```bash
terraform apply
```

Type `yes` when prompted to confirm.

### 7. Verify Deployment

After deployment, Terraform will output important resource information:

```bash
terraform output
```

You should see outputs like:
- S3 bucket name and ARN
- CloudTrail ARN
- CloudWatch log group name
- SNS topic ARN
- SQS queue URL
- Kinesis Firehose stream name
- DynamoDB table name

## Configuration

### Required Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `aws_account_id` | Your AWS account ID | `"123456789012"` |

### Optional Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `aws_region` | AWS region for resources | `"us-east-1"` |
| `project_name` | Project name for tagging | `"monitoring-pipeline"` |
| `environment` | Environment name | `"prod"` |
| `naming_prefix` | Prefix for resource names | `"aws-mon-log"` |
| `s3_bucket_name` | Custom S3 bucket name | Auto-generated |
| `sns_email_subscriptions` | List of email addresses for alerts | `[]` |
| `cloudwatch_retention_days` | CloudWatch log retention period | `30` |
| `enable_cloudtrail` | Enable CloudTrail module | `true` |
| `enable_cloudwatch` | Enable CloudWatch module | `true` |
| `enable_sns` | Enable SNS module | `true` |
| `enable_sqs` | Enable SQS module | `true` |
| `enable_kinesis_firehose` | Enable Kinesis Firehose module | `true` |
| `enable_dynamodb` | Enable DynamoDB module | `true` |

### Feature Flags

Use feature flags to selectively enable/disable components:

```hcl
# Minimal setup - only S3 and CloudTrail
enable_cloudtrail        = true
enable_cloudwatch        = false
enable_sns               = false
enable_sqs               = false
enable_kinesis_firehose  = false
enable_dynamodb          = false
```

## Module Documentation

### S3 Module

**Purpose**: Centralized logging bucket with encryption, versioning, and lifecycle policies.

**Features**:
- Versioning enabled for audit trail
- Server-side encryption (AES256)
- Public access blocking
- Lifecycle rules (90d → Standard-IA, 180d → Glacier, 365d deletion)
- Bucket policy for CloudTrail write access

### CloudTrail Module

**Purpose**: AWS API activity logging for compliance and security auditing.

**Features**:
- Multi-region trail enabled
- Log file validation enabled
- Global service events included
- Logs stored in S3 bucket

### CloudWatch Module

**Purpose**: Real-time log aggregation and monitoring.

**Features**:
- Configurable log retention
- Optional CPU utilization alarm
- Supports custom metrics

### SNS Module

**Purpose**: Notification delivery system.

**Features**:
- Multiple email subscriptions supported
- Email protocol (confirmations required)
- Extensible for SMS, Lambda, etc.

### SQS Module

**Purpose**: Asynchronous message queuing for log processing.

**Features**:
- Standard queue type
- Fully managed

### Kinesis Firehose Module

**Purpose**: Real-time log streaming and delivery.

**Features**:
- Automatic IAM role creation
- S3 destination with compression (GZIP)
- Buffering configuration (5 MB / 300 seconds)
- Prefix-based organization

### DynamoDB Module

**Purpose**: State and metadata tracking.

**Features**:
- Pay-per-request billing
- DynamoDB Streams enabled
- Configurable hash key

## Outputs

After deployment, the following outputs are available:

```bash
# View all outputs
terraform output

# View specific output
terraform output s3_bucket_name
```

### Available Outputs

- `s3_bucket_name` - S3 logging bucket name
- `s3_bucket_arn` - S3 bucket ARN
- `cloudtrail_arn` - CloudTrail ARN
- `cloudtrail_name` - CloudTrail name
- `cloudwatch_log_group_name` - CloudWatch log group name
- `cloudwatch_log_group_arn` - CloudWatch log group ARN
- `sns_topic_arn` - SNS topic ARN
- `sqs_queue_url` - SQS queue URL
- `sqs_queue_arn` - SQS queue ARN
- `kinesis_firehose_stream_name` - Kinesis Firehose stream name
- `dynamodb_table_name` - DynamoDB table name
- `dynamodb_table_arn` - DynamoDB table ARN
- `dynamodb_table_stream_arn` - DynamoDB stream ARN

## Security Considerations

### IAM Permissions

This Terraform configuration requires permissions to create and manage:
- S3 buckets and policies
- CloudTrail trails
- CloudWatch log groups and alarms
- SNS topics and subscriptions
- SQS queues
- Kinesis Firehose delivery streams
- DynamoDB tables
- IAM roles and policies

### Best Practices Implemented

✅ **S3 Bucket Security**
- Public access blocked at bucket level
- Server-side encryption enabled
- Versioning enabled for immutability
- Bucket policy restricts access to CloudTrail

✅ **CloudTrail Security**
- Multi-region trail for comprehensive coverage
- Log file validation enabled
- Encrypted at rest in S3

✅ **IAM Security**
- Least privilege IAM roles
- Service-specific assume role policies
- Inline policies for better auditability

✅ **State File Security**
- Encrypted state files in S3
- DynamoDB state locking prevents concurrent modifications

### Additional Recommendations

1. **Enable MFA for state bucket**: Add MFA delete to Terraform state bucket
2. **Restrict IAM access**: Use IAM conditions to restrict access by IP or VPC
3. **Enable GuardDuty**: For additional threat detection
4. **Configure SNS encryption**: Enable SNS topic encryption for sensitive alerts
5. **Review S3 access logs**: Enable S3 access logging on the logging bucket itself

## Cost Optimization

### Estimated Monthly Costs

Costs vary based on usage, but here are approximate estimates for typical workloads:

- **S3**: $5-20/month (depends on log volume)
- **CloudTrail**: $2/trail + $0.10/100k events
- **CloudWatch**: $0.50/GB ingested + $0.03/GB storage
- **SNS**: $0.50/million requests
- **SQS**: $0.40/million requests
- **Kinesis Firehose**: $0.029/GB + S3 PUT costs
- **DynamoDB**: Pay-per-request (minimal cost for low usage)

### Cost Optimization Tips

1. **Adjust log retention**: Lower CloudWatch retention to 7-14 days
2. **Use S3 lifecycle policies**: Configured to transition to cheaper storage
3. **Disable unused modules**: Use feature flags to disable components
4. **Filter CloudTrail events**: Configure CloudTrail to only log specific events
5. **Monitor with Cost Explorer**: Set up budget alerts

```hcl
# Example: Minimal cost configuration
cloudwatch_retention_days = 7
enable_kinesis_firehose  = false  # If not needed
enable_dynamodb          = false  # If not needed
```

## Troubleshooting

### Common Issues

#### 1. S3 Bucket Name Already Exists

**Error**: `BucketAlreadyExists` or `BucketAlreadyOwnedByYou`

**Solution**: S3 bucket names must be globally unique. Specify a unique name:

```hcl
s3_bucket_name = "my-company-logs-${var.aws_account_id}-${var.environment}"
```

#### 2. Insufficient IAM Permissions

**Error**: `AccessDenied` or `UnauthorizedOperation`

**Solution**: Ensure your AWS credentials have the required permissions. Use an admin role or add specific permissions.

#### 3. CloudTrail Cannot Write to S3

**Error**: `InsufficientS3BucketPolicyException`

**Solution**: This should be handled automatically by the S3 bucket policy. If it persists, verify:
- S3 bucket policy is applied
- CloudTrail service has write permissions

#### 4. Backend Configuration Error

**Error**: `Error configuring the backend "s3"`

**Solution**:
- Ensure the S3 bucket and DynamoDB table exist
- Verify bucket name and table name in `backend.tf`
- Or comment out `backend.tf` to use local state

#### 5. SNS Email Subscription Not Confirmed

**Issue**: Emails not received from SNS

**Solution**: Check your email for SNS subscription confirmation and click the confirmation link.

### Debugging Tips

```bash
# Enable detailed logging
export TF_LOG=DEBUG
terraform plan

# Validate configuration
terraform validate

# Check state
terraform state list

# View specific resource
terraform state show module.s3.aws_s3_bucket.this

# Refresh state
terraform refresh
```

## Maintenance

### Updating Infrastructure

```bash
# Pull latest changes
git pull origin main

# Review changes
terraform plan

# Apply updates
terraform apply
```

### Destroying Infrastructure

To tear down all resources:

```bash
terraform destroy
```

**Warning**: This will delete all resources including logs! Ensure you have backups if needed.

### Partial Destruction

To destroy specific modules:

```hcl
# In terraform.tfvars, disable modules
enable_kinesis_firehose = false
enable_dynamodb = false
```

Then run:
```bash
terraform apply
```

## CI/CD Integration

### GitHub Actions Example

Create `.github/workflows/terraform.yml`:

```yaml
name: Terraform

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  terraform:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: Setup Terraform
        uses: hashicorp/setup-terraform@v2

      - name: Configure AWS Credentials
        uses: aws-actions/configure-aws-credentials@v2
        with:
          aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
          aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          aws-region: us-east-1

      - name: Terraform Init
        run: terraform init
        working-directory: ./terraform

      - name: Terraform Validate
        run: terraform validate
        working-directory: ./terraform

      - name: Terraform Plan
        run: terraform plan
        working-directory: ./terraform

      - name: Terraform Apply
        if: github.ref == 'refs/heads/main'
        run: terraform apply -auto-approve
        working-directory: ./terraform
```

## Contributing

Contributions are welcome! Please follow these guidelines:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Make your changes
4. Run `terraform fmt` to format code
5. Run `terraform validate` to validate configuration
6. Commit your changes (`git commit -m 'Add amazing feature'`)
7. Push to the branch (`git push origin feature/amazing-feature`)
8. Open a Pull Request

### Code Standards

- Use consistent naming conventions
- Add comments for complex logic
- Update README for new features
- Test changes in a dev environment first

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For issues, questions, or contributions:

- **Issues**: [GitHub Issues](https://github.com/shehuj/aws_monitoring_and_logging_pipeline-TF/issues)
- **Discussions**: [GitHub Discussions](https://github.com/shehuj/aws_monitoring_and_logging_pipeline-TF/discussions)

## Changelog

### v2.0.0 (Latest)
- Fixed CloudTrail and DynamoDB module outputs
- Added IAM role creation for Kinesis Firehose
- Improved S3 bucket policy for CloudTrail
- Added support for multiple SNS email subscriptions
- Cleaned up hardcoded values and sensitive data
- Fixed conditional outputs for optional modules
- Added comprehensive documentation
- Improved variable consistency across modules

### v1.0.0
- Initial release with basic functionality

## Acknowledgments

- AWS documentation for best practices
- Terraform AWS provider documentation
- HashiCorp's Terraform guides

---

**Maintained by**: DevOps Team
**Last Updated**: December 2024
**Terraform Version**: >= 1.0.0
**AWS Provider Version**: >= 4.0.0
