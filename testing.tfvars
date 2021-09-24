# General
region = "us-east-2"
# Lambda 
lambda_function_name = "kinesis-to-dynamodb"
lambda_description   = "Terraform provisioned Lambda to process Kinesis events and to store them into a DynamoDB table"
lambda_handler       = "lambda.lambda_handler"
lambda_runtime       = "python3.8"
lambda_source_path = "function.zip"
# Kinesis
kinesis_stream = "application-logs-stream"
kinesis_shard_count = 1
kinesis_retention_period = 24
# DynamoDB
dynamodb_table_name = "application-logs-table"
dynamodb_table_hash_key = "id"
dynamodb_table_hash_key_type = "N"
dynamodb_table_billing_mode = "PROVISIONED"
dynamodb_table_read_capacity = 20
dynamodb_table_write_capacity = 20
