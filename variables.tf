################################################################################
# VPC
################################################################################

variable "name" {
  description = <<-EOF
    Name prefix for all resources.
    Example: "my-vpc"
  EOF
  type        = string
}

variable "vpc_cidr" {
  description = <<-EOF
    CIDR block for VPC.
    Example: "10.0.0.0/16"
  EOF
  type        = string
  default     = "10.0.0.0/16"
}

variable "instance_tenancy" {
  description = <<-EOF
    Tenancy option for instances launched into the VPC.
    Valid values: "default", "dedicated", "host"
    Example: "default"
  EOF
  type        = string
  default     = "default"
}

variable "ipv4_ipam_pool_id" {
  description = <<-EOF
    The ID of an IPv4 IPAM pool to use for VPC CIDR allocation.
    Example: "ipam-pool-0123456789abcdef0"
  EOF
  type        = string
  default     = null
}

variable "ipv4_netmask_length" {
  description = <<-EOF
    The netmask length of the IPv4 CIDR to request from IPAM pool.
    Example: 16
  EOF
  type        = number
  default     = null
}

variable "ipv6_cidr_block" {
  description = <<-EOF
    IPv6 CIDR block for VPC.
    Example: "2600:1f18::/56"
  EOF
  type        = string
  default     = null
}

variable "ipv6_ipam_pool_id" {
  description = <<-EOF
    The ID of an IPv6 IPAM pool to use for VPC CIDR allocation.
    Example: "ipam-pool-0123456789abcdef0"
  EOF
  type        = string
  default     = null
}

variable "ipv6_netmask_length" {
  description = <<-EOF
    The netmask length of the IPv6 CIDR to request from IPAM pool.
    Example: 56
  EOF
  type        = number
  default     = null
}

variable "ipv6_cidr_block_network_border_group" {
  description = <<-EOF
    The network border group for the IPv6 CIDR block.
    Example: "us-east-1"
  EOF
  type        = string
  default     = null
}

variable "assign_generated_ipv6_cidr_block" {
  description = <<-EOF
    Requests an Amazon-provided IPv6 CIDR block with /56 prefix.
    Example: true
  EOF
  type        = bool
  default     = false
}

variable "enable_dns_hostnames" {
  description = <<-EOF
    Enable DNS hostnames in VPC.
    Example: true
  EOF
  type        = bool
  default     = true
}

variable "enable_dns_support" {
  description = <<-EOF
    Enable DNS support in VPC.
    Example: true
  EOF
  type        = bool
  default     = true
}

variable "enable_network_address_usage_metrics" {
  description = <<-EOF
    Enable Network Address Usage metrics for VPC.
    Example: true
  EOF
  type        = bool
  default     = false
}

################################################################################
# Subnets
################################################################################

variable "subnet_names" {
  description = <<-EOF
    List of subnet names.
    Example: ["public-1", "public-2", "private-1", "private-2"]
  EOF
  type        = list(string)
  default     = []
}

variable "subnet_cidr_blocks" {
  description = <<-EOF
    List of CIDR blocks for subnets. Must match the order of subnet_names.
    Example: ["10.0.1.0/24", "10.0.2.0/24", "10.0.11.0/24", "10.0.12.0/24"]
  EOF
  type        = list(string)
  default     = []
}

variable "subnet_availability_zones" {
  description = <<-EOF
    List of availability zones for subnets. Must match the order of subnet_names.
    Example: ["ap-northeast-2a", "ap-northeast-2c", "ap-northeast-2a", "ap-northeast-2c"]
  EOF
  type        = list(string)
  default     = []
}

variable "subnet_availability_zone_ids" {
  description = <<-EOF
    List of availability zone IDs for subnets. Use instead of availability_zone names.
    Example: ["apne2-az1", "apne2-az3", "apne2-az1", "apne2-az3"]
  EOF
  type        = list(string)
  default     = []
}

variable "subnet_map_public_ip_on_launch" {
  description = <<-EOF
    List of map_public_ip_on_launch values for subnets. Set true for public subnets.
    Example: [true, true, false, false]
  EOF
  type        = list(bool)
  default     = []
}

variable "subnet_assign_ipv6_address_on_creation" {
  description = <<-EOF
    List of assign_ipv6_address_on_creation values for subnets.
    Example: [true, true, false, false]
  EOF
  type        = list(bool)
  default     = []
}

variable "subnet_enable_dns64" {
  description = <<-EOF
    List of enable_dns64 values for subnets. Enables DNS64 for IPv6-only subnets.
    Example: [false, false, true, true]
  EOF
  type        = list(bool)
  default     = []
}

variable "subnet_enable_lni_at_device_index" {
  description = <<-EOF
    List of enable_lni_at_device_index values for subnets. Device index for local network interface.
    Example: [1, 1, 1, 1]
  EOF
  type        = list(number)
  default     = []
}

variable "subnet_enable_resource_name_dns_aaaa_record_on_launch" {
  description = <<-EOF
    List of enable_resource_name_dns_aaaa_record_on_launch values for subnets.
    Example: [true, true, false, false]
  EOF
  type        = list(bool)
  default     = []
}

variable "subnet_enable_resource_name_dns_a_record_on_launch" {
  description = <<-EOF
    List of enable_resource_name_dns_a_record_on_launch values for subnets.
    Example: [true, true, true, true]
  EOF
  type        = list(bool)
  default     = []
}

variable "subnet_ipv6_cidr_blocks" {
  description = <<-EOF
    List of IPv6 CIDR blocks for subnets.
    Example: ["2600:1f18::/64", "2600:1f18:0:1::/64", "", ""]
  EOF
  type        = list(string)
  default     = []
}

variable "subnet_ipv6_native" {
  description = <<-EOF
    List of ipv6_native values for subnets. Set true for IPv6-only subnets.
    Example: [false, false, false, false]
  EOF
  type        = list(bool)
  default     = []
}

variable "subnet_private_dns_hostname_type_on_launch" {
  description = <<-EOF
    List of private_dns_hostname_type_on_launch values for subnets.
    Valid values: "ip-name", "resource-name"
    Example: ["ip-name", "ip-name", "ip-name", "ip-name"]
  EOF
  type        = list(string)
  default     = []
}

variable "subnet_tags" {
  description = <<-EOF
    Map of subnet names to additional tags.
    Example: {
      "public-1"  = { Type = "public", Tier = "web" }
      "public-2"  = { Type = "public", Tier = "web" }
      "private-1" = { Type = "private", Tier = "app" }
      "private-2" = { Type = "private", Tier = "app" }
    }
  EOF
  type        = map(map(string))
  default     = {}
}

################################################################################
# Route Tables
################################################################################

variable "route_table_names" {
  description = <<-EOF
    List of route table names.
    Example: ["public", "private-1", "private-2"]
  EOF
  type        = list(string)
  default     = []
}

variable "route_table_propagating_vgws" {
  description = <<-EOF
    Map of route table names to list of Virtual Gateway IDs for route propagation.
    Example: {
      "private-1" = ["vgw-0123456789abcdef0"]
      "private-2" = ["vgw-0123456789abcdef0"]
    }
  EOF
  type        = map(list(string))
  default     = {}
}

variable "route_table_tags" {
  description = <<-EOF
    Map of route table names to additional tags.
    Example: {
      "public"    = { Type = "public" }
      "private-1" = { Type = "private" }
      "private-2" = { Type = "private" }
    }
  EOF
  type        = map(map(string))
  default     = {}
}

################################################################################
# Routes
################################################################################

variable "route_names" {
  description = <<-EOF
    List of route names. Used as identifiers for each route.
    Example: ["public-igw", "private-1-nat", "private-2-nat"]
  EOF
  type        = list(string)
  default     = []
}

variable "route_route_table_names" {
  description = <<-EOF
    List of route table names for each route. Must match the order of route_names.
    Example: ["public", "private-1", "private-2"]
  EOF
  type        = list(string)
  default     = []
}

variable "route_destination_cidr_blocks" {
  description = <<-EOF
    List of destination CIDR blocks for routes. Must match the order of route_names.
    Example: ["0.0.0.0/0", "0.0.0.0/0", "0.0.0.0/0"]
  EOF
  type        = list(string)
  default     = []
}

variable "route_destination_ipv6_cidr_blocks" {
  description = <<-EOF
    List of destination IPv6 CIDR blocks for routes.
    Example: ["::/0", "", ""]
  EOF
  type        = list(string)
  default     = []
}

variable "route_destination_prefix_list_ids" {
  description = <<-EOF
    List of destination prefix list IDs for routes.
    Example: ["pl-0123456789abcdef0", "", ""]
  EOF
  type        = list(string)
  default     = []
}

variable "route_carrier_gateway_ids" {
  description = <<-EOF
    List of carrier gateway IDs for routes (Wavelength zones).
    Example: ["cagw-0123456789abcdef0", "", ""]
  EOF
  type        = list(string)
  default     = []
}

variable "route_core_network_arns" {
  description = <<-EOF
    List of core network ARNs for routes (Cloud WAN).
    Example: ["arn:aws:networkmanager::123456789012:core-network/core-network-0123456789abcdef0", "", ""]
  EOF
  type        = list(string)
  default     = []
}

variable "route_egress_only_gateway_ids" {
  description = <<-EOF
    List of egress only gateway IDs for routes (IPv6 outbound only).
    Example: ["eigw-0123456789abcdef0", "", ""]
  EOF
  type        = list(string)
  default     = []
}

variable "route_gateway_ids" {
  description = <<-EOF
    List of gateway IDs for routes (Internet Gateway or Virtual Private Gateway).
    Example: ["igw-0123456789abcdef0", "", ""]
  EOF
  type        = list(string)
  default     = []
}

variable "route_nat_gateway_ids" {
  description = <<-EOF
    List of NAT gateway IDs for routes.
    Example: ["", "nat-0123456789abcdef0", "nat-0123456789abcdef1"]
  EOF
  type        = list(string)
  default     = []
}

variable "route_network_interface_ids" {
  description = <<-EOF
    List of network interface IDs for routes.
    Example: ["eni-0123456789abcdef0", "", ""]
  EOF
  type        = list(string)
  default     = []
}

variable "route_transit_gateway_ids" {
  description = <<-EOF
    List of transit gateway IDs for routes.
    Example: ["tgw-0123456789abcdef0", "", ""]
  EOF
  type        = list(string)
  default     = []
}

variable "route_vpc_endpoint_ids" {
  description = <<-EOF
    List of VPC endpoint IDs for routes (Gateway Load Balancer endpoints).
    Example: ["vpce-0123456789abcdef0", "", ""]
  EOF
  type        = list(string)
  default     = []
}

variable "route_vpc_peering_connection_ids" {
  description = <<-EOF
    List of VPC peering connection IDs for routes.
    Example: ["pcx-0123456789abcdef0", "", ""]
  EOF
  type        = list(string)
  default     = []
}

################################################################################
# Route Table Associations
################################################################################

variable "route_table_associations" {
  description = <<-EOF
    Map of subnet names to route table names for association.
    Key: subnet name (from subnet_names)
    Value: route table name (from route_table_names)
    Example: {
      "<subnet_name>" = "<route_table_name>"
      "public-1"      = "public"
      "public-2"      = "public"
      "private-1"     = "private-1"
      "private-2"     = "private-2"
    }
  EOF
  type        = map(string)
  default     = {}
}

################################################################################
# Common
################################################################################

variable "tags" {
  description = <<-EOF
    Tags to apply to all resources.
    Example: {
      Environment = "dev"
      Project     = "my-project"
      ManagedBy   = "terraform"
    }
  EOF
  type        = map(string)
  default     = {}
}
