terraform {
  required_version = "1.15.1"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region                      = var.aws_region
  access_key                  = var.aws_access_key
  secret_key                  = var.aws_secret_key
  skip_credentials_validation = var.is_local
  skip_metadata_api_check     = var.is_local
  skip_requesting_account_id  = var.is_local

  endpoints {
    s3             = var.aws_endpoint
    dynamodb       = var.aws_endpoint
    lambda         = var.aws_endpoint
    sqs            = var.aws_endpoint
    sns            = var.aws_endpoint
    iam            = var.aws_endpoint
    cloudformation = var.aws_endpoint
    ec2            = var.aws_endpoint
  }
}