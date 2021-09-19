# General
region = "us-east-2"
# Lambda 
lambda_function_name = "terraform"
lambda_description   = "Terraform provisioned Lambda to process Kinesis events and to store them into a DynamoDB table"
lambda_handler       = "lambda.lambda_handler"
lambda_runtime       = "python3.8"
lambda_source_path = "function.zip"
# Kinesis
kinesis_stream = "json"
