locals {
  ################################################################################
  # Subnets
  ################################################################################

  subnets = {
    for idx, name in var.subnet_names : name => {
      cidr_block                                         = var.subnet_cidr_blocks[idx]
      availability_zone                                  = length(var.subnet_availability_zones) > idx ? var.subnet_availability_zones[idx] : null
      availability_zone_id                               = length(var.subnet_availability_zone_ids) > idx ? var.subnet_availability_zone_ids[idx] : null
      map_public_ip_on_launch                            = length(var.subnet_map_public_ip_on_launch) > idx ? var.subnet_map_public_ip_on_launch[idx] : false
      assign_ipv6_address_on_creation                    = length(var.subnet_assign_ipv6_address_on_creation) > idx ? var.subnet_assign_ipv6_address_on_creation[idx] : false
      enable_dns64                                       = length(var.subnet_enable_dns64) > idx ? var.subnet_enable_dns64[idx] : false
      enable_lni_at_device_index                         = length(var.subnet_enable_lni_at_device_index) > idx ? var.subnet_enable_lni_at_device_index[idx] : null
      enable_resource_name_dns_aaaa_record_on_launch     = length(var.subnet_enable_resource_name_dns_aaaa_record_on_launch) > idx ? var.subnet_enable_resource_name_dns_aaaa_record_on_launch[idx] : false
      enable_resource_name_dns_a_record_on_launch        = length(var.subnet_enable_resource_name_dns_a_record_on_launch) > idx ? var.subnet_enable_resource_name_dns_a_record_on_launch[idx] : false
      ipv6_cidr_block                                    = length(var.subnet_ipv6_cidr_blocks) > idx ? var.subnet_ipv6_cidr_blocks[idx] : null
      ipv6_native                                        = length(var.subnet_ipv6_native) > idx ? var.subnet_ipv6_native[idx] : false
      private_dns_hostname_type_on_launch                = length(var.subnet_private_dns_hostname_type_on_launch) > idx ? var.subnet_private_dns_hostname_type_on_launch[idx] : null
      tags                                               = lookup(var.subnet_tags, name, {})
    }
  }

  ################################################################################
  # Route Tables
  ################################################################################

  route_tables = {
    for name in var.route_table_names : name => {
      propagating_vgws = lookup(var.route_table_propagating_vgws, name, [])
      tags             = lookup(var.route_table_tags, name, {})
    }
  }

  ################################################################################
  # Routes
  ################################################################################

  routes = {
    for idx, name in var.route_names : name => {
      route_table_name             = var.route_route_table_names[idx]
      destination_cidr_block       = length(var.route_destination_cidr_blocks) > idx ? var.route_destination_cidr_blocks[idx] : null
      destination_ipv6_cidr_block  = length(var.route_destination_ipv6_cidr_blocks) > idx ? var.route_destination_ipv6_cidr_blocks[idx] : null
      destination_prefix_list_id   = length(var.route_destination_prefix_list_ids) > idx ? var.route_destination_prefix_list_ids[idx] : null
      carrier_gateway_id           = length(var.route_carrier_gateway_ids) > idx ? var.route_carrier_gateway_ids[idx] : null
      core_network_arn             = length(var.route_core_network_arns) > idx ? var.route_core_network_arns[idx] : null
      egress_only_gateway_id       = length(var.route_egress_only_gateway_ids) > idx ? var.route_egress_only_gateway_ids[idx] : null
      gateway_id                   = length(var.route_gateway_ids) > idx ? var.route_gateway_ids[idx] : null
      nat_gateway_id               = length(var.route_nat_gateway_ids) > idx ? var.route_nat_gateway_ids[idx] : null
      network_interface_id         = length(var.route_network_interface_ids) > idx ? var.route_network_interface_ids[idx] : null
      transit_gateway_id           = length(var.route_transit_gateway_ids) > idx ? var.route_transit_gateway_ids[idx] : null
      vpc_endpoint_id              = length(var.route_vpc_endpoint_ids) > idx ? var.route_vpc_endpoint_ids[idx] : null
      vpc_peering_connection_id    = length(var.route_vpc_peering_connection_ids) > idx ? var.route_vpc_peering_connection_ids[idx] : null
    }
  }
}