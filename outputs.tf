################################################################################
# VPC
################################################################################

output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = aws_vpc.main.cidr_block
}

output "vpc_arn" {
  description = "The ARN of the VPC"
  value       = aws_vpc.main.arn
}

################################################################################
# Subnets
################################################################################

output "subnet_ids" {
  description = "Map of subnet names to IDs"
  value       = { for k, v in aws_subnet.main : k => v.id }
}

output "subnet_arns" {
  description = "Map of subnet names to ARNs"
  value       = { for k, v in aws_subnet.main : k => v.arn }
}

output "subnet_cidr_blocks" {
  description = "Map of subnet names to CIDR blocks"
  value       = { for k, v in aws_subnet.main : k => v.cidr_block }
}

################################################################################
# Route Tables
################################################################################

output "route_table_ids" {
  description = "Map of route table names to IDs"
  value       = { for k, v in aws_route_table.main : k => v.id }
}

output "route_table_arns" {
  description = "Map of route table names to ARNs"
  value       = { for k, v in aws_route_table.main : k => v.arn }
}

################################################################################
# Route Table Associations
################################################################################

output "route_table_association_ids" {
  description = "Map of subnet names to route table association IDs"
  value       = { for k, v in aws_route_table_association.main : k => v.id }
}