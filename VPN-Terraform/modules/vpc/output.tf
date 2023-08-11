output "vpc_id" {
  value = module.vpc.vpc_id
}

output "vpc_cidr" {
  value = module.vpc.vpc_cidr_block
}

output "name" {
  value = module.vpc.name
}

output "vpc_public_subnets" {
  value = module.vpc.public_subnets
}

output "vpc_private_subnets" {
  value = module.vpc.private_subnets
}

output "security_group_public" {
  value = aws_security_group.public-sg.id
}

output "security_group_public_name" {
  value = aws_security_group.public-sg.name
}


# output "security_group_private" {
#   value = aws_security_group.private.id
# }

output "outpost_subnets" {
  description = "List of IDs of outpost subnets"
  value       = module.vpc.outpost_subnets
}

output "public_route_table_ids" {
  description = "List of IDs of public route tables"
  value       = module.vpc.public_route_table_ids
}

output "private_route_table_ids" {
  description = "List of IDs of private route tables"
  value       = module.vpc.private_route_table_ids
}

