################################################################################
# VPC
################################################################################

resource "aws_vpc" "main" {
  cidr_block                           = var.vpc_cidr
  instance_tenancy                     = var.instance_tenancy
  ipv4_ipam_pool_id                    = var.ipv4_ipam_pool_id
  ipv4_netmask_length                  = var.ipv4_netmask_length
  ipv6_cidr_block                      = var.ipv6_cidr_block
  ipv6_ipam_pool_id                    = var.ipv6_ipam_pool_id
  ipv6_netmask_length                  = var.ipv6_netmask_length
  ipv6_cidr_block_network_border_group = var.ipv6_cidr_block_network_border_group
  assign_generated_ipv6_cidr_block     = var.assign_generated_ipv6_cidr_block
  enable_dns_hostnames                 = var.enable_dns_hostnames
  enable_dns_support                   = var.enable_dns_support
  enable_network_address_usage_metrics = var.enable_network_address_usage_metrics

  tags = merge(
    var.tags,
    {
      Name = var.name
    }
  )
}

################################################################################
# Subnets
################################################################################

resource "aws_subnet" "main" {
  for_each = local.subnets

  vpc_id                                         = aws_vpc.main.id
  cidr_block                                     = each.value.cidr_block
  availability_zone                              = each.value.availability_zone
  availability_zone_id                           = each.value.availability_zone_id
  map_public_ip_on_launch                        = each.value.map_public_ip_on_launch
  assign_ipv6_address_on_creation                = each.value.assign_ipv6_address_on_creation
  enable_dns64                                   = each.value.enable_dns64
  enable_lni_at_device_index                     = each.value.enable_lni_at_device_index
  enable_resource_name_dns_aaaa_record_on_launch = each.value.enable_resource_name_dns_aaaa_record_on_launch
  enable_resource_name_dns_a_record_on_launch    = each.value.enable_resource_name_dns_a_record_on_launch
  ipv6_cidr_block                                = each.value.ipv6_cidr_block
  ipv6_native                                    = each.value.ipv6_native
  private_dns_hostname_type_on_launch            = each.value.private_dns_hostname_type_on_launch

  tags = merge(
    var.tags,
    each.value.tags,
    {
      Name = "${var.name}-${each.key}"
    }
  )
}

################################################################################
# Route Tables
################################################################################

resource "aws_route_table" "main" {
  for_each = local.route_tables

  vpc_id           = aws_vpc.main.id
  propagating_vgws = each.value.propagating_vgws

  tags = merge(
    var.tags,
    each.value.tags,
    {
      Name = "${var.name}-${each.key}"
    }
  )
}

################################################################################
# Routes
################################################################################

resource "aws_route" "main" {
  for_each = local.routes

  route_table_id             = aws_route_table.main[each.value.route_table_name].id
  destination_cidr_block     = each.value.destination_cidr_block
  destination_ipv6_cidr_block = each.value.destination_ipv6_cidr_block
  destination_prefix_list_id = each.value.destination_prefix_list_id
  carrier_gateway_id         = each.value.carrier_gateway_id
  core_network_arn           = each.value.core_network_arn
  egress_only_gateway_id     = each.value.egress_only_gateway_id
  gateway_id                 = each.value.gateway_id
  nat_gateway_id             = each.value.nat_gateway_id
  network_interface_id       = each.value.network_interface_id
  transit_gateway_id         = each.value.transit_gateway_id
  vpc_endpoint_id            = each.value.vpc_endpoint_id
  vpc_peering_connection_id  = each.value.vpc_peering_connection_id
}

################################################################################
# Route Table Associations
################################################################################

resource "aws_route_table_association" "main" {
  for_each = var.route_table_associations

  subnet_id      = aws_subnet.main[each.key].id
  route_table_id = aws_route_table.main[each.value].id
}