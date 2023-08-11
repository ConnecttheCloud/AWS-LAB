#! /bin/bash
# sudo yum update -y &&
# sudo yum upgrade -y &&
# sudo cd $HOME/ &&
sudo curl https://raw.githubusercontent.com/ConnecttheCloud/AWS-LAB/main/OpenSwan/openswan-config.sh -o install.sh &&
sudo chmod +x $HOME/install.sh