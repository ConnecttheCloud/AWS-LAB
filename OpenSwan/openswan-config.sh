#/bin/bash

sudo  yum update -y  2&>1 /dev/null
sudo yum upgrade -y  2&>1 /dev/null

sudo yum install openswan -y 2&>1 /dev/null

tun1=Tunnel1
tun2=Tunnel2
read -p "$tun1 on-prem PublicIP:" onpremip
read -p "$tun1 AWS PublicIP:" awsip
read -p	"$tun1 on-prem PrivateIP PREFIX:" onpremprivateip
read -p "$tun1 AWS PrivateIP PREFIX:" awsprivateip
read -p "$tun1 type PREShARED KEY:" presharedkey

read -p "$tun2 on-prem PublicIP:" onpremip2
read -p "$tun2 AWS PublicIP:" awsip2
read -p "$tun2 type PREShARED KEY:" presharedkey2


sudo cat > /etc/sysctl.conf <<EOL
net.ipv4.ip_forward = 1
net.ipv4.conf.all.accept_redirects = 0
net.ipv4.conf.all.send_redirects = 0
net.ipv4.conf.default.rp_filter = 0
net.ipv4.conf.default.accept_redirects = 0
net.ipv4.conf.default.send_redirects = 0
EOL

sudo sysctl -p 

sudo mkdir -p /etc/ipsec.d/ && sudo touch /etc/ipsec.d/aws.conf &&
sudo touch /etc/ipsec.d/aws.secrets 





sudo cat > /etc/ipsec.d/aws.conf<<EOL
conn Tunnel1
	authby=secret
	auto=start
	left=%defaultroute
	leftid=$onpremip
	right=$awsip
	type=tunnel
	ikelifetime=8h
	keylife=1h
	phase2alg=aes128-sha1;modp1024
	ike=aes128-sha1;modp1024
	keyingtries=%forever
	keyexchange=ike
	leftsubnet=$onpremprivateip
	rightsubnet=$awsprivateip
	dpddelay=10
	dpdtimeout=30
	dpdaction=restart_by_peer
	overlapip=yes
EOL


sudo cat >> /etc/ipsec.d/aws.secrets <<EOL
$onpremip $awsip: PSK "$presharedkey"
EOL

sudo cat >> /etc/ipsec.d/aws.conf<<EOL
conn Tunnel2
	authby=secret
	auto=start
	left=%defaultroute
	leftid=$onpremip2
	right=$awsip2
	type=tunnel
	ikelifetime=8h
	keylife=1h
	phase2alg=aes128-sha1;modp1024
	ike=aes128-sha1;modp1024
	keyingtries=%forever
	keyexchange=ike
	leftsubnet=$onpremprivateip
	rightsubnet=$awsprivateip
	dpddelay=10
	dpdtimeout=30
	dpdaction=restart_by_peer
	overlapip=yes
EOL

sudo cat >>/etc/ipsec.d/aws.secrets <<EOL
$onpremip2 $awsip2: PSK "$presharedkey2"
EOL



sudo systemctl start ipsec
sudo systemctl enable ipsec
sudo systemctl restart ipsec





