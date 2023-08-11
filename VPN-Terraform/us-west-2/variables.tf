# variable "access_key" {
#   type        = string
#   description = "AWS access key"
# }
# variable "secret_key" {
#   type        = string
#   description = "AWS secret key"
# }
# variable "token" {
#   type        = string
#   description = "AWS token"
# }

variable "aws_region" {
  type        = string
  description = "AWS region"
}

variable "infra_env" {
  type        = string
  description = "Deploying infrastucture"
}

variable "vpcname" {
  type        = string
  description = "VPC name"
}

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR block"
}

variable "azs" {
  type = list(string)
}

variable "public_subnets" {
  type = list(string)
}

variable "private_subnets" {
  type = list(string)
}

variable "public_subnet_names" {
  type = list(string)
  #default = ["NYP-subnet-Web-1a", "NYP-subnet-Web-1b"]
}

variable "private_subnet_names" {
  type = list(string)
  #default = ["NYP-subnet-App-1a", "NYP-subnet-App-1b", "NYP-subnet-App-1c"]
}

variable "public-sg" {
  type = string
}

variable "additional_tags" {
  default = {
    Project     = "Site2SiteVPN"
    ManagedBy   = "Terraform"
    Environment = "Production"
  }
  description = "Additional resource tags"
  type        = map(string)
}




