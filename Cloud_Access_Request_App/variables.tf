variable "AWS_REGION" {
  description = "AWS region where Cloud Access Request App resources will be deployed"
  type        = string
  default     = "us-east-1"  
}

variable "app_name" {
  description = "Name of the application"
  type        = string
  default     = "Cloud_Access_Request_App"  
}
