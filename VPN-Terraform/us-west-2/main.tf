#creat VPC using vpc modules.
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


# Import an existing key pair
resource "aws_key_pair" "example_key_pair" {
  key_name   = "example-key-pair" # Replace with your existing key pair name
  public_key = <<EOF
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDJmyZdH41sIm136K5/yZx54pLwD9WZcHjXZTVYfi2ZPPp0LgWi1m1Glc2bkID9CtzxwoSoDbYe2bqgOkWcAHVXJ4l9UWODuNEb2yb4giH+ndwQW/SM7HQZdD1U+X+jKYBJtZKbnTguIqvbat82eo5nRphiBMcVROxMDaG9xMim9Ms2nBFnC/leZ5tLFUCxAuYq755DY/7GekBgC4TwcambWejjttMRZ5IWrzckArIY/IDJFX5nWEYJ1As0LOCMsdPyiTA2aT1Ss7iXUd9/GkmU52FQ7RxV4nW/3sUwDz0bH2nQHVnazejADBWL/Q8lLBVNfkv1Sla+cOT1SU77Uq2P sgctc\shwelin.htet@T200017
EOF
}


resource "aws_eip" "PIP" {
  instance = aws_instance.router1.id
  domain   = "vpc"
  tags = {
    Name = "Router1IP"
  }
}

resource "aws_network_interface" "router1-interface" {
  subnet_id       = element(module.vpc.vpc_public_subnets, 0)
  private_ips     = ["172.16.0.100"]
  security_groups = [module.vpc.security_group_public]
}

resource "aws_instance" "router1" {
  ami           = "ami-0ea832bf7873542df" # us-west-2
  instance_type = "t2.micro"
  key_name      = aws_key_pair.example_key_pair.key_name
  user_data     = filebase64("./initial.sh")

  network_interface {
    network_interface_id = aws_network_interface.router1-interface.id
    device_index         = 0
    # associate_public_ip_address = true
  }
  tags = {
    Name = "Router1"
  }
}

resource "aws_network_interface" "test-svr" {
  subnet_id = element(module.vpc.vpc_private_subnets, 1)
  # private_ips     = ["10.0.0.100"]
  security_groups = [module.vpc.security_group_public]
}

resource "aws_instance" "aws-svr" {
  ami           = "ami-0ea832bf7873542df" # us-west-2
  instance_type = "t2.micro"
  key_name      = aws_key_pair.example_key_pair.key_name

  network_interface {
    network_interface_id = aws_network_interface.test-svr.id
    device_index         = 0
  }
  tags = {
    Name = "test-server"
  }
}
#############################################

# # Create an EC2 instance
# resource "aws_instance" "example_instance" {
#   ami                    = "ami-0ea832bf7873542df" # Replace with your desired AMI ID
#   instance_type          = "t2.micro"              # Replace with your desired instance type
#   key_name               = aws_key_pair.example_key_pair.key_name
#   subnet_id              = element(module.vpc.vpc_public_subnets, 0)
#   vpc_security_group_ids = [module.vpc.security_group_public]

#   tags = {
#     Name = "Router1"
#   }
# }

# resource "aws_network_interface" "router1-interface" {
#   subnet_id       = element(module.vpc.vpc_public_subnets, 0)
#   private_ips     = ["172.16.0.100"]
#   security_groups = [module.vpc.security_group_public]

# }

# resource "aws_instance" "router1" {
#   ami           = "ami-0ea832bf7873542df" # us-west-2
#   instance_type = "t2.micro"
#   # key_name      = aws_key_pair.example_key_pair.key_name

#   network_interface {
#     network_interface_id = aws_network_interface.router1-interface.id
#     device_index         = 0
#     associate_public_ip_address = true
#   }
#   tags = {
#     Name = "Router1"
#   }
# }
###########################################
