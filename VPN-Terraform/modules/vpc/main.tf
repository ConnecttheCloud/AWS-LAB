


module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name                 = var.vpcname
  cidr                 = var.vpc_cidr
  azs                  = var.azs
  private_subnets      = var.private_subnets
  public_subnets       = var.public_subnets
  public_subnet_names  = var.public_subnet_names
  private_subnet_names = var.private_subnet_names
  ## this attribute map subnet to assign auto public ip address
  map_public_ip_on_launch = true
  enable_nat_gateway      = false
  # enable_vpn_gateway      = false
  manage_default_security_group = var.defaultsg
  # manage_default_network_acl    = false
  # manage_default_route_table    = false
  # manage_default_security_group = false
#  customer_gateways = {
#     IP1 = {
#       bgp_asn     = var.customer_gateways["IP1"].bgp_asn
#       ip_address  = var.customer_gateways["IP1"].ip_address
#       device_name = var.customer_gateways["IP1"].device_name
#     },
#     # IP2 = {
#     #   bgp_asn    = 65112
#     #   ip_address = "5.6.7.8"
#     # }
#   }

  tags = var.additional_tags

}
