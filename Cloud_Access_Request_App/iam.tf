module "cloud_access_request_lambda_execution_role" {
  source = "terraform-aws-modules/terraform-aws-iam"
  version = "~ 5.50.0"
  
  name  = "${var.app_name}-lambda-execution-role"
  

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Effect    = "Allow"
        Sid       = ""
      }
    ]
  })
  policies = [
    "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole", 
    "arn:aws:iam::aws:policy/service-role/AWSLambdaRole" 
  ]
}


module "cloud_access_request_lambda_layer_execution_role" {
  source = "terraform-aws-modules/terraform-aws-iam"
  
  name               = "${var.app_name}-lambda--layer-execution-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Effect    = "Allow"
        Sid       = ""
      }
    ]
  })
  
  policies = [
    "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  ]
}

module "cloud_access_request_apigateway_invoke_lambda_role" {
  source = "terraform-aws-modules/terraform-aws-iam"
  name               = "${var.app_name}-apigateway-invoke-lambda-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Principal = {
          Service = "apigateway.amazonaws.com"
        }
        Effect    = "Allow"
        Sid       = ""
      }
    ]
  })
  
  policies = [
    "arn:aws:iam::aws:policy/service-role/AWSLambdaRole",
  ]
}
