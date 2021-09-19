terraform {
  backend "s3" {
    bucket = "terraform-state-philranzato"
    key    = "terraform-state/terraform.state"
    region = "us-east-2"
  }
}

module "lambda_function" {
  source = "github.com/PhilRanzato/terraform-module-lambda-aws"

  region = var.region

  # Lambda parameters
  lambda_function_name = var.lambda_function_name
  lambda_description   = var.lambda_description
  lambda_handler       = var.lambda_handler
  lambda_runtime       = var.lambda_runtime
  lambda_source_path = var.lambda_source_path

  # Kinesis
  kinesis_stream = var.kinesis_stream
}
