
module "vpc" {
  source = "../modules/vpc"

  vpcname              = var.vpcname
  infra_env            = var.infra_env
  vpc_cidr             = var.vpc_cidr
  azs                  = var.azs
  public_subnets       = var.public_subnets
  private_subnets      = var.private_subnets
  public_subnet_names  = var.public_subnet_names
  private_subnet_names = var.private_subnet_names
  public-sg            = var.public-sg
  defaultsg            = false
  enable_vpn_gateway   = false
}

data "aws_eip" "by_filter" {
  provider = aws.usw2
  filter {
    name   = "tag:Name"
    values = ["Router1IP"]
  }
}

resource "aws_customer_gateway" "example" {
  bgp_asn    = 65000
  ip_address = data.aws_eip.by_filter.public_ip # Replace with your customer gateway's public IP address
  type       = "ipsec.1"
}

resource "aws_vpn_gateway" "vpngw" {
  vpc_id = module.vpc.vpc_id # Replace with your VPC ID
}

resource "aws_vpn_gateway_route_propagation" "example" {
  vpn_gateway_id = aws_vpn_gateway.vpngw.id
  route_table_id = "${module.vpc.public_route_table_ids[0]}"
}

resource "aws_vpn_connection" "vpn-con-sg-uswest2" {
  customer_gateway_id = aws_customer_gateway.example.id
  vpn_gateway_id      = aws_vpn_gateway.vpngw.id
  type                = "ipsec.1"

  static_routes_only    = true # Set to true if you're using static routes only
  tunnel1_preshared_key = "Helloworld123"
  tunnel2_preshared_key = "Helloworld123"

}

resource "aws_vpn_connection_route" "to-uswest2-route" {
  destination_cidr_block = "172.16.0.0/16"
  vpn_connection_id      = aws_vpn_connection.vpn-con-sg-uswest2.id
}


#configuration for EC2 instance 
# Import an existing key pair
resource "aws_key_pair" "example_key_pair" {
  key_name   = "example-key-pair" # Replace with your existing key pair name
  public_key = <<EOF
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDJmyZdH41sIm136K5/yZx54pLwD9WZcHjXZTVYfi2ZPPp0LgWi1m1Glc2bkID9CtzxwoSoDbYe2bqgOkWcAHVXJ4l9UWODuNEb2yb4giH+ndwQW/SM7HQZdD1U+X+jKYBJtZKbnTguIqvbat82eo5nRphiBMcVROxMDaG9xMim9Ms2nBFnC/leZ5tLFUCxAuYq755DY/7GekBgC4TwcambWejjttMRZ5IWrzckArIY/IDJFX5nWEYJ1As0LOCMsdPyiTA2aT1Ss7iXUd9/GkmU52FQ7RxV4nW/3sUwDz0bH2nQHVnazejADBWL/Q8lLBVNfkv1Sla+cOT1SU77Uq2P sgctc\shwelin.htet@T200017
EOF
}

resource "aws_network_interface" "web-svrinterface" {
  subnet_id       = element(module.vpc.vpc_public_subnets, 0)
  private_ips     = ["10.0.0.100"]
  security_groups = [module.vpc.security_group_public]
}

resource "aws_instance" "aws-svr" {
  ami           = "ami-059b01eb1dee1e15c" # ap-southeast-1
  instance_type = "t2.micro"
  key_name      = aws_key_pair.example_key_pair.key_name

  network_interface {
    network_interface_id = aws_network_interface.web-svrinterface.id
    device_index         = 0
  }
  tags = {
    Name = "web-server"
  }
}

###########################################

