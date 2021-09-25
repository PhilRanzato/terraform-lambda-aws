# terraform-lambda-aws

Deploys an infrastructure to test an AWS Lambda Workflow tht consists in these three steps:
- Send logs to an AWS Kinesis Data Stream
- Process logs with a Lambda function
- Save processed logs into a DynamoDB table

For more information, visit [lambda-aws](https://github.com/PhilRanzato/lambda-aws).

## Features

The repository is based on a single `main.tf` terraform file that:
- Configures as backend an AWS s3 bucket
- Provisions an AWS Kinesis Data Stream and an AWS DynamoDB table
- Provisions an AWS Lambda function starting from a `.zip` file

An example of `.zip` file is provided [here](function.example.zip).

## Requirements

A `.zip` file containing an AWS Lambda code is mandatory. You can choose its name and update the variable `lambda_function_name`. See [variables](#variables) for more information

## Code structure

`main.tf` calls 3 different modules:
- [terraform-module-kinesis](https://github.com/PhilRanzato/terraform-module-kinesis)
- [terraform-module-dynamodb](https://github.com/PhilRanzato/terraform-module-dynamodb)
- [terraform-module-lambda-aws](https://github.com/PhilRanzato/terraform-module-lambda-aws)

Modules `terraform-module-kinesis` and `terraform-module-dynamodb` should be executed before the Lambda:

```shell
# Adds AWS credentials
export TF_VAR_access_key="xxxxxxx"
export TF_VAR_secret_key="yyyyyyy"
# init the s3 backend
terraform init
# Specify which environment you need
export TFVARS_FILE=testing.tfvars
# Create the plan for the lambda dependencies (Kinesis data stream and DynamoDB table)
terraform plan -var-file=$TFVARS_FILE -target=module.kinesis_stream -target=module.dynamodb_table -out dependencies
# Apply the labda dependencies resources
terraform apply "dependencies"
# Plan the Lambda provisioning
terraform plan -var-file=$TFVARS_FILE -out lambda_function
# Provision the Lambda
terraform apply "lambda_function"
```

## Variables

```powershell
# AWS Region
region = "us-east-2"
# Lambda function name
lambda_function_name = "kinesis-to-dynamodb"
# Lambda function description
lambda_description   = "Terraform provisioned Lambda to process Kinesis events and to store them into a DynamoDB table"
# Lambda function handler
lambda_handler       = "lambda.lambda_handler"
# Lambda function runtime
lambda_runtime       = "python3.8"
# Lambda function .zip file to load
lambda_source_path = "function.zip"
# Name of the AWS Kinesis Data Stream
kinesis_stream = "application-logs-stream"
# Number of shards of the AWS Kinesis Data Stream
kinesis_shard_count = 1
# Retention period (how much time it saves its events) of the AWS Kinesis Data Stream
kinesis_retention_period = 24
# DynamoDB table name
dynamodb_table_name = "application-logs-table"
# DynamoDB table primary hash key
dynamodb_table_hash_key = "id"
# DynamoDB table primary hash key type (S,N,B - String, Number, Binary)
dynamodb_table_hash_key_type = "N"
# DynamoDB table billing mode (PROVISIONED/PAY_PER_REQUEST)
dynamodb_table_billing_mode = "PROVISIONED"
# DynamoDB table read capacity
dynamodb_table_read_capacity = 20
# DynamoDB table write capacity
dynamodb_table_write_capacity = 20
```

## CICD

A [Jenkinsfile](Jenkinsfile) that validates the Terraform workflow is provided in the repository.
