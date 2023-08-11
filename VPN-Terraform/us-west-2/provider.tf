terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

#   backend "s3" {
#     profile = "cloudcasts"
#     region  = "us-east-2"
#   }


provider "aws" {
  region  = var.aws_region
  profile = "default"
  # shared_credentials_files = "~/.aws/credentials"
}