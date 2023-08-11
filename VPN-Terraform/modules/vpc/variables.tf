variable "infra_env" {
  type        = string
  description = "infrastructure environment"
}

variable "vpcname" {
  type        = string
  description = "VPC name"
}

variable "vpc_cidr" {
  type        = string
  description = "The IP range to use for the VPC"
}

variable "azs" {
  type        = list(string)
  description = "AZs to create subnets into"
}

variable "public_subnets" {
  type        = list(string)
  description = "subnets to create for public network traffic, one per AZ"
}

variable "private_subnets" {
  type        = list(string)
  description = "subnets to create for private network traffic, one per AZ"
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

variable "ingress_ports" {
  type        = list(number)
  description = "incoming ports to allow"
  default     = [22, 80, 443]
}

variable "defaultsg" {
  type = bool
}

variable "enable_vpn_gateway" {
  type  = bool
  
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


# variable "customer_gateways" {
#   description = "Map of customer gateway details per region and gateway name."

#   type = map(object({
#     bgp_asn       = number
#     ip_address    = string
#     device_name = string
#   }))
# }
