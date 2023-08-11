aws_region           = "us-west-2"
infra_env            = "VPNLAB"
vpcname              = "OnPrem-VPNLAB-vpc"
vpc_cidr             = "172.16.0.0/16"
azs                  = ["us-west-2a", "us-west-2b", ]
public_subnets       = ["172.16.0.0/24", "172.16.1.0/24"]
private_subnets      = ["172.16.2.0/24", "172.16.3.0/24"]
public_subnet_names  = ["OnPrem-VPNLAB-Publicsubnet1", "OnPrem-VPNLAB-Publicsubnet2"]
private_subnet_names = ["OnPrem-VPNLAB-Privatesubnet1", "OnPrem-VPNLAB-Privatesubnet2"]
public-sg            = "NYP-VPNLAB-sg"
# access_key      = "ASIAXLLOCA47YZHFCXMA"
# secret_key      = "NV8u2rCqG7T08nzmtMRiiR1hlI0rJnKks7aqaFVo"
# token           = "FwoGZXIvYXdzECMaDImk5ACA5+X3GEvSGCLKAcL6WlTyMJqGP9Mso2aalrEGfCBbwBqkFg0JctGO+PJ35CrReOsoOM0SWcWezSAzYbbJ3+2jU6vHox7Q6mo5Ha5Z56VL0/E43NWpN3VyLCiyeVNVkvE+RaWqJmTnNrxQKFPmFRr9HRLABR9gx1X5k4oxB8yzC6YhbzjYWARoNPkCuPN2QNdfjrTpYNNYUBZVDv9YI5ReQgWm8Ufs9ap5K1VhXfsjZouTCOnKTe1A3YbvRx7iIQe4qSe9I3kuT3dvXdSQIk5cY6L6Hiwo//vIowYyLaIjuj0qtTdGNS9sv63iDapsTPYYv1W8blWgoh6GoHcujUYEDbWiUqriabxKWw=="
