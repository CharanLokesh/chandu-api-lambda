output "cloud_access_request_lambda_function_arn" {
  value = module.cloud_access_request_lambda_function.lambda_function_arn
}

output "cloud_access_request_lambda_layer_arn" {
  value = module.cloud_access_request_lambda_layer.layer_arn
}
