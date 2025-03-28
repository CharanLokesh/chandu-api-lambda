
module "cloud_access_request_lambda_layer" {
  source = "terraform-aws-modules/lambda/aws"
  version = "~> 7.20.0"
  create_layer = true
  layer_name         = "${var.app_name}-lambda-layer"
  description        = "Lambda Layer for Cloud Access Request App"
  compatible_runtimes = ["nodejs14.x", "python3.8"]  
  # source_path = "${path.module}"
  s3_bucket = "cloud-access-request-app"  # S3 bucket for the Lambda layer zip
  s3_prefix    = "lambda-layers/layer.zip"  
}

module "cloud_access_request_lambda_function" {
  source = "terraform-aws-modules/lambda/aws"
  version = "~> 7.20.0"

  function_name = "${var.app_name}-lambda-function"
  description   = "Lambda function for Cloud Access Request App"
  runtime       = "nodejs14.x"  
  handler       = "index.handler"  
  role_name = ""
  layers = [
    module.cloud_access_request_lambda_layer.arn
    ]

  environment_variables = {
    Serverless = "Terraform"  
  }
  store_on_s3 = true
  s3_bucket = "cloud-access-request-app"
  s3_prefix = "lamda-function/"

  allowed_triggers = {
    api_gateway = {
      service =api_gateway
      source_arn = ""
    }
  }
  tags = {
    "creator" = "terraform"
  }
}
