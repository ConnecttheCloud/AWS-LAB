aws_region           = "ap-southeast-1"
infra_env            = "VPNLAB"
vpcname              = "Cloud-VPNLAB-vpc"
vpc_cidr             = "10.0.0.0/16"
azs                  = ["ap-southeast-1a", "ap-southeast-1b", ]
public_subnets       = ["10.0.0.0/24", "10.0.1.0/24"]
private_subnets      = ["10.0.2.0/24", "10.0.3.0/24"]
public_subnet_names  = ["Cloud-VPNLAB-Publicsubnet1", "Cloud-VPNLAB-Publicsubnet2"]
private_subnet_names = ["Cloud-VPNLAB-Privatesubnet1", "Cloud-VPNLAB-Privatesubnet2"]
public-sg            = "NYP-VPNLAB-sg"
# access_key      = "ASIAXLLOCA47YZHFCXMA"
# secret_key      = "NV8u2rCqG7T08nzmtMRiiR1hlI0rJnKks7aqaFVo"
# token           = "FwoGZXIvYXdzECMaDImk5ACA5+X3GEvSGCLKAcL6WlTyMJqGP9Mso2aalrEGfCBbwBqkFg0JctGO+PJ35CrReOsoOM0SWcWezSAzYbbJ3+2jU6vHox7Q6mo5Ha5Z56VL0/E43NWpN3VyLCiyeVNVkvE+RaWqJmTnNrxQKFPmFRr9HRLABR9gx1X5k4oxB8yzC6YhbzjYWARoNPkCuPN2QNdfjrTpYNNYUBZVDv9YI5ReQgWm8Ufs9ap5K1VhXfsjZouTCOnKTe1A3YbvRx7iIQe4qSe9I3kuT3dvXdSQIk5cY6L6Hiwo//vIowYyLaIjuj0qtTdGNS9sv63iDapsTPYYv1W8blWgoh6GoHcujUYEDbWiUqriabxKWw=="


customer_gateways = {
  "IP1" = {
    bgp_asn     = 65000
    ip_address  = "34.215.77.243"
    device_name = "OpenSwan-Box"
  }
  #   "IP2" = {
  #     bgp_asn     = 65000
  #     ip_address  = "9.10.11.12"
  #     device_name = "Palo Alto"
  #   }
}