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

# Output the fetched Elastic IP address
output "eip_address" {
  value = data.aws_eip.by_filter.public_ip
}

output "public_route_table_ids" {
  description = "List of IDs of public route tables"
  value       = module.vpc.public_route_table_ids
}

output "private_route_table_ids" {
  description = "List of IDs of private route tables"
  value       = module.vpc.private_route_table_ids
}