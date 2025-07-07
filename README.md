# monitoring_and_logging_pipeline-TF
AWS automated monitoirng and logging pipeline with AWS core services using terraform.

how to use the code:

first clone to the repo to your local computer,
`git clone https://github.com/shehuj/aws_monitoring_and_logging_pipeline-TF.git`

Next, move to the terraform directory
`cd monitoring_and_logging_pipeline-TF/aws-monitoring-logging-pipeline`

and run your terraform commands, for example, initialize the worksapce,
`terraform init`

and run the plan command to see the action plan and what terraform will build
`terraform plan`

then you run the apply
`terraform apply`


Here is the flie tree for the entire set up;

aws-monitoring-logging-pipeline/
├── main.tf
├── variables.tf
├── outputs.tf
├── modules/
│   ├── s3/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── cloudtrail/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── cloudwatch/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── sns/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── sqs/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── kinesis-firehose/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── dynamodb/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
└── versions.tf

let me know if you hit any errors and we can collaborate, also feel free to add any modifications or improvements to the code. Thank you.
