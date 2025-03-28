locals {
  lambda_function_arn = module.cloud_access_request_lambda_function.lambda_function_arn
}


module "api_gateway" {
  source = "terraform-aws-modules/apigateway-v2"
  version = "~> 5.1.0"

  name        = "${var.app_name}-api"
  description = "API Gateway for processing access requests"
  endpoint_type = "REGIONAL"

  resources = [
    {
      path        = "request-access"  
      http_method = "POST"            
      integration = {
        type                  = "AWS_PROXY"  
        uri                   = "arn:aws:apigateway:${var.region}:lambda:path/2015-03-31/functions/${local.lambda_function_arn}/invocations"
        integration_http_method = "POST"
      }
    }
  ]
}

# Allow API Gateway to invoke the Lambda function
resource "aws_lambda_permission" "allow_api_gateway" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  principal     = "apigateway.amazonaws.com"
  function_name = aws_lambda_function.request_access_lambda.function_name
}

# Deploy API Gateway to a specific stage
resource "aws_api_gateway_deployment" "deployment" {
  depends_on = [
    module.api_gateway
  ]
  rest_api_id = module.api_gateway.rest_api_id
  stage_name  = "dev"
}