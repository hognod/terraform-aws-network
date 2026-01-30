# terraform-aws-network

AWS VPC 네트워크 인프라를 구성하는 Terraform 모듈입니다.

## 포함된 리소스

- VPC
- Subnets
- Route Tables
- Routes
- Route Table Associations

## 사용법

### 기본 사용 예시

```hcl
module "network" {
  source = "git::http://gitlab.mas-cloud.io/terraform/terraform-aws-networks.git"

  name     = "my-vpc"
  vpc_cidr = "10.0.0.0/16"

  # Subnets
  subnet_names              = ["public-1", "public-2", "private-1", "private-2"]
  subnet_cidr_blocks        = ["10.0.1.0/24", "10.0.2.0/24", "10.0.11.0/24", "10.0.12.0/24"]
  subnet_availability_zones = ["ap-northeast-2a", "ap-northeast-2c", "ap-northeast-2a", "ap-northeast-2c"]
  subnet_map_public_ip_on_launch = [true, true, false, false]

  # Route Tables
  route_table_names = ["public", "private"]

  # Route Table Associations
  route_table_associations = {
    "public-1"  = "public"
    "public-2"  = "public"
    "private-1" = "private"
    "private-2" = "private"
  }

  tags = {
    Environment = "dev"
    Project     = "my-project"
  }
}
```

### Routes 설정 예시

```hcl
module "network" {
  source = "git::http://gitlab.mas-cloud.io/terraform/terraform-aws-networks.git"

  # ... (VPC, Subnet, Route Table 설정)

  # Routes
  route_names                   = ["public-igw", "private-nat"]
  route_route_table_names       = ["public", "private"]
  route_destination_cidr_blocks = ["0.0.0.0/0", "0.0.0.0/0"]
  route_gateway_ids             = [aws_internet_gateway.main.id, ""]
  route_nat_gateway_ids         = ["", aws_nat_gateway.main.id]
}
```
## Inputs

### VPC

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | 모든 리소스의 Name prefix | `string` | - | yes |
| vpc_cidr | VPC CIDR 블록 | `string` | `"10.0.0.0/16"` | no |
| instance_tenancy | 인스턴스 테넌시 (default, dedicated, host) | `string` | `"default"` | no |
| ipv4_ipam_pool_id | IPv4 IPAM 풀 ID | `string` | `null` | no |
| ipv4_netmask_length | IPv4 CIDR 넷마스크 길이 (IPAM 사용 시) | `number` | `null` | no |
| ipv6_cidr_block | IPv6 CIDR 블록 | `string` | `null` | no |
| ipv6_ipam_pool_id | IPv6 IPAM 풀 ID | `string` | `null` | no |
| ipv6_netmask_length | IPv6 CIDR 넷마스크 길이 (IPAM 사용 시) | `number` | `null` | no |
| ipv6_cidr_block_network_border_group | IPv6 CIDR 네트워크 경계 그룹 | `string` | `null` | no |
| assign_generated_ipv6_cidr_block | Amazon 제공 IPv6 CIDR 블록 할당 여부 | `bool` | `false` | no |
| enable_dns_hostnames | DNS 호스트네임 활성화 | `bool` | `true` | no |
| enable_dns_support | DNS 지원 활성화 | `bool` | `true` | no |
| enable_network_address_usage_metrics | 네트워크 주소 사용량 메트릭 활성화 | `bool` | `false` | no |

### Subnets

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| subnet_names | 서브넷 이름 목록 | `list(string)` | `[]` | no |
| subnet_cidr_blocks | 서브넷 CIDR 블록 목록 | `list(string)` | `[]` | no |
| subnet_availability_zones | 가용 영역 목록 | `list(string)` | `[]` | no |
| subnet_availability_zone_ids | 가용 영역 ID 목록 | `list(string)` | `[]` | no |
| subnet_map_public_ip_on_launch | 퍼블릭 IP 자동 할당 여부 | `list(bool)` | `[]` | no |
| subnet_assign_ipv6_address_on_creation | IPv6 주소 자동 할당 여부 | `list(bool)` | `[]` | no |
| subnet_enable_dns64 | DNS64 활성화 여부 | `list(bool)` | `[]` | no |
| subnet_enable_lni_at_device_index | 로컬 네트워크 인터페이스 디바이스 인덱스 | `list(number)` | `[]` | no |
| subnet_enable_resource_name_dns_aaaa_record_on_launch | AAAA DNS 레코드 활성화 여부 | `list(bool)` | `[]` | no |
| subnet_enable_resource_name_dns_a_record_on_launch | A DNS 레코드 활성화 여부 | `list(bool)` | `[]` | no |
| subnet_ipv6_cidr_blocks | 서브넷 IPv6 CIDR 블록 목록 | `list(string)` | `[]` | no |
| subnet_ipv6_native | IPv6 전용 서브넷 여부 | `list(bool)` | `[]` | no |
| subnet_private_dns_hostname_type_on_launch | 프라이빗 DNS 호스트네임 타입 (ip-name, resource-name) | `list(string)` | `[]` | no |
| subnet_tags | 서브넷별 추가 태그 | `map(map(string))` | `{}` | no |

### Route Tables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| route_table_names | 라우트 테이블 이름 목록 | `list(string)` | `[]` | no |
| route_table_propagating_vgws | 라우트 테이블별 VPN Gateway 전파 설정 | `map(list(string))` | `{}` | no |
| route_table_tags | 라우트 테이블별 추가 태그 | `map(map(string))` | `{}` | no |

### Routes

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| route_names | 라우트 이름 목록 | `list(string)` | `[]` | no |
| route_route_table_names | 각 라우트가 속할 라우트 테이블 이름 | `list(string)` | `[]` | no |
| route_destination_cidr_blocks | 목적지 CIDR 블록 | `list(string)` | `[]` | no |
| route_destination_ipv6_cidr_blocks | 목적지 IPv6 CIDR 블록 | `list(string)` | `[]` | no |
| route_destination_prefix_list_ids | 목적지 Prefix List ID | `list(string)` | `[]` | no |
| route_carrier_gateway_ids | Carrier Gateway ID (Wavelength zones) | `list(string)` | `[]` | no |
| route_core_network_arns | Core Network ARN (Cloud WAN) | `list(string)` | `[]` | no |
| route_egress_only_gateway_ids | Egress Only Gateway ID (IPv6) | `list(string)` | `[]` | no |
| route_gateway_ids | Internet Gateway / VPN Gateway ID | `list(string)` | `[]` | no |
| route_nat_gateway_ids | NAT Gateway ID | `list(string)` | `[]` | no |
| route_network_interface_ids | Network Interface ID | `list(string)` | `[]` | no |
| route_transit_gateway_ids | Transit Gateway ID | `list(string)` | `[]` | no |
| route_vpc_endpoint_ids | VPC Endpoint ID (Gateway Load Balancer) | `list(string)` | `[]` | no |
| route_vpc_peering_connection_ids | VPC Peering Connection ID | `list(string)` | `[]` | no |

### Route Table Associations

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| route_table_associations | 서브넷-라우트 테이블 연결 (key: subnet name, value: route table name) | `map(string)` | `{}` | no |

### Common

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| tags | 모든 리소스에 적용할 태그 | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| vpc_id | VPC ID |
| vpc_cidr_block | VPC CIDR 블록 |
| vpc_arn | VPC ARN |
| subnet_ids | 서브넷 이름별 ID 맵 |
| subnet_arns | 서브넷 이름별 ARN 맵 |
| subnet_cidr_blocks | 서브넷 이름별 CIDR 블록 맵 |
| route_table_ids | 라우트 테이블 이름별 ID 맵 |
| route_table_arns | 라우트 테이블 이름별 ARN 맵 |
| route_table_association_ids | 서브넷별 라우트 테이블 연결 ID 맵 |

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0.0 |
| aws | >= 5.0.0 |
