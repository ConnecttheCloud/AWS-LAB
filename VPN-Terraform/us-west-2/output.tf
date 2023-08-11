output "vpc_id" {
  value = module.vpc.vpc_id
}

output "VPC_name" {
  value = module.vpc.name
}

output "vpc_public_subnets" {
  value = module.vpc.vpc_public_subnets
}

output "vpc_private_subnets" {
  value = module.vpc.vpc_private_subnets
}

output "Security_Group_ID" {
  value = module.vpc.security_group_public
}

output "ELastic_IP_Address" {
  value = aws_eip.PIP.public_ip
}